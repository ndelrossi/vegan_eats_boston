class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :place
  validates :user_id, presence: true
  validates :place_id, presence: true
end
