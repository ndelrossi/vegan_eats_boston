class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :reviews, dependent: :destroy
  
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }

  has_attached_file :avatar, s3_permissions: :private, s3_server_side_encryption: :aes256,
  :styles => {
    :original => ["200x200>",:jpg],
    :thumb => ["50x50>",:jpg] },
  :convert_options => {
    :original => "-quality 70 -strip -resize x400 -resize '400x<' -resize 50% -gravity center -crop 200x200+0+0 +repage",
    :thumb => "-quality 80 -strip -resize x100 -resize '100x<' -resize 50% -gravity center -crop 50x50+0+0 +repage" }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  default_scope -> { order('created_at DESC') }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!(validate: false)
    UserMailer.password_reset(self).deliver
  end

  def send_activation
    if !self.activation_token?
      generate_token(:activation_token)
      save!(validate: false)
    end
    UserMailer.activate_account(self).deliver
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end

    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column])
    end
end
