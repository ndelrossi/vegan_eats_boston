class Post < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :title, presence: true, length: { maximum: 80 }
  validates :content, presence: true
  validates :user_id, presence: true
end
