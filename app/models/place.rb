class Place < ActiveRecord::Base
  
  has_many :reviews, dependent: :destroy
  has_attached_file :primary_image
  validates_attachment_content_type :primary_image, :content_type => /\Aimage\/.*\Z/
  geocoded_by :full_address
  after_validation :geocode
  acts_as_taggable_on :categories

  scope :contains, -> (name) { where("lower(name) like ?", "%#{name.downcase}%")}
  scope :cities, -> (cities) { where address_city: cities }
  scope :sort, -> (sort) {
    sort == 'rating' ? direction = "DESC" : direction = "ASC"
    order("#{sort} #{direction}")
  }

  def full_address
    "#{address_line_1} #{address_city}, #{address_state}"
  end

  def get_average_rating
    rating_sum = 0
    self.reviews.each do |r|
      rating_sum += r.rating
    end
    rating = rating_sum.to_f / reviews.size.to_f
  end
end
