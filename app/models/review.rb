class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :place, counter_cache: true
  validates :user_id, presence: true
  validates :place_id, presence: true

  def content_stub
    #self.content[0..250].html_safe
    #self.content.split("\n\n", 2)[0].html_safe
    truncate(self.content, length: 1, separator: '<br />')
  end

  def content_more
    #self.content[251..-1].html_safe
    #self.split("\n\n", 2)[1..-1].html_safe
  end
end
