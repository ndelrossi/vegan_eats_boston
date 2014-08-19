class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :place, counter_cache: true
  validates :user_id, presence: true
  validates :place_id, presence: true
  default_scope -> { order('created_at DESC') }
end
