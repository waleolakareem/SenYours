class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save   :downcase_email
  before_create :create_activation_digest
  mount_uploader :avatar, AvatarUploader
  attr_encrypted :ssn, key: ENV['decyher_ssn']
  has_many :seniors, class_name: 'Appointment', foreign_key: 'senior_id', dependent: :destroy
  has_many :companions, class_name: 'Appointment', foreign_key: 'companion_id', dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :reviewers, class_name: 'Review', foreign_key: 'reviewer_id', dependent: :destroy
  has_many :available_days, dependent: :destroy
  has_many :messages, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 },allow_nil: true
  validates :dob, presence: true
  validates :identification, presence: true
  validate :over_18
  validates :phone_number, phony_plausible: true,uniqueness: true
  # Normalizes the attribute itself before validation
  phony_normalize :phone_number, default_country_code: 'US'


  has_secure_password
  validate  :avatar_size
  # minimum cost to decrypt in development and high cost for production chapt 8
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  def conversations
    Conversation.where("sender_id = ? OR recipient_id = ?", self.id, self.id)
  end

  def phone_number=(value)
    super(value.blank? ? nil : value.gsub(/[^\w\s]/, ''))
  end

  # Validates that user is older than 18 years of age
  def over_18
    return nil unless dob.present?
    if dob + 18.years >= Date.today
      errors.add(:dob, "can't be under 18")
    end
  end
  # Validates the size of an uploaded picture.
  def avatar_size
    if avatar.size > 5.megabytes
      errors.add(:avatar, "should be less than 5MB")
    end
  end

  # Activates an account.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest:  User.digest(reset_token), reset_sent_at: Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  #Send founder an email
  def send_signed_up_email
    UserMailer.signed_up(self).deliver_now
  end
  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
