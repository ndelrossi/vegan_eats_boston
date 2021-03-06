class Place < ActiveRecord::Base
  include Filterable
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :reviews, dependent: :destroy
  has_attached_file :primary_image, 
                    s3_permissions: :private, 
                    s3_server_side_encryption: :aes256,
                    default_url: "/assets/missing-place.jpg",
                    styles: { original: ["200x200>",:jpg] },
                    convert_options: { original: "-quality 70 -strip 
                                       -resize x400 -resize '400x<' 
                                       -resize 50% -gravity center 
                                       -crop 200x200+0+0 +repage" }

  validates_attachment_content_type :primary_image, :content_type => /\Aimage\/.*\Z/
  geocoded_by :full_address
  after_validation :geocode
  acts_as_taggable_on :categories
  
  before_save { self.url_website = Place.strip_url(url_website)
                self.url_menu = Place.strip_url(url_menu) }

  scope :contains, -> (name) { 
    where("lower(places.name) like ?", "%#{name.downcase.gsub('.', ' ')}%")
  }
  scope :cities, -> (cities) { where address_city: cities }
  scope :categories, -> (categories) {
    tagged_with(categories, :any => true)
  }
  scope :sort, -> (sort) {
    sort == 'rating' ? direction = "DESC" : direction = "ASC"
    order("#{sort} #{direction}")
  }
  scope :highest_rated, -> { 
    includes(:categories).
    order(rating: :desc)
  }

  def full_address
    "#{address_line_1} #{address_city}, #{address_state}"
  end

  def update_rating
    update_attribute(:rating, reviews.average(:rating))
  end

  def should_generate_new_friendly_id?
    true
  end

  def self.all_cities
    pluck(:address_city).uniq
  end

  private

  def self.strip_url(url)
    url.sub(/https?\:\/\//, '')
  end
end
