class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :place, counter_cache: true
  validates :rating, presence: true, 
     :numericality => { :greater_than => 0, :less_than_or_equal_to => 100, :message => "can not be blank" }
  validates :user_id, presence: true
  validates :place_id, presence: true

  after_save :update_place_rating

  default_scope -> { order('created_at DESC') }

  private

  def update_place_rating
    place.update_rating
  end
end
