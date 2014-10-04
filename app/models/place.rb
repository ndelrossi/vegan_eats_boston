class Place < ActiveRecord::Base
  
  has_many :reviews, dependent: :destroy
  has_attached_file :primary_image, s3_permissions: :private, s3_server_side_encryption: :aes256,
  :default_url => "/assets/missing-place.jpg",
  :styles => {
    :original => ["200x200>",:jpg] },
  :convert_options => {
    :original => "-quality 70 -strip -resize x400 -resize '400x<' -resize 50% -gravity center -crop 200x200+0+0 +repage" }

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
    self.reviews.inject(0.0) { |sum, review| sum + review.rating } / reviews.size
  end
end
