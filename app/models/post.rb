class Post < ActiveRecord::Base
  belongs_to :user
  has_attached_file :image, s3_permissions: :private, s3_server_side_encryption: :aes256,
  :styles => {
    :original => ["1000x500>",:jpg] },
  :convert_options => {
    :original => "-quality 70 -strip" }

  validates :title, presence: true, length: { maximum: 80 }
  validates :content, presence: true
  validates :user_id, presence: true
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  default_scope -> { order('created_at DESC') }
  scope :approved, -> { where(approved: true) }
end
