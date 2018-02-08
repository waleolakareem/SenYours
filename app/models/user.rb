class User < ApplicationRecord
  before_save { email.downcase! }
  mount_uploader :avatar, AvatarUploader
  attr_encrypted :ssn, key: 'This is a key that is 256 bits!!'
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
  validates :privacy_policy, presence: true
  validates :terms_of_service, presence: true
  validates :identification, presence: true
  validate :over_18

  has_secure_password
  validate  :avatar_size

  def conversations
    Conversation.where("sender_id = ? OR recipient_id = ?", self.id, self.id)
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
end
