class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, counter_cache: true

  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :content, presence: true, length: { maximum: 500 }
end
