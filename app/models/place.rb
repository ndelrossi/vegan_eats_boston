class Place < ActiveRecord::Base
  
  has_many :reviews, dependent: :destroy
  has_attached_file :primary_image
  validates_attachment_content_type :primary_image, :content_type => /\Aimage\/.*\Z/
  geocoded_by :full_address
  after_validation :geocode

  def full_address
    "#{address_line_1} #{address_city}, #{address_state}"
  end
end
