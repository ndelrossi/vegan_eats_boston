class Post < ActiveRecord::Base
  belongs_to :user
  has_attached_file :image
  default_scope -> { order('created_at DESC') }
  validates :title, presence: true, length: { maximum: 80 }
  validates :content, presence: true
  validates :user_id, presence: true
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
