class Place < ActiveRecord::Base
  has_attached_file :primary_image
  validates_attachment_content_type :primary_image, :content_type => /\Aimage\/.*\Z/
end
