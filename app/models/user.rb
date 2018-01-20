class User < ApplicationRecord
  before_save { email.downcase! }
  mount_uploader :avatar, AvatarUploader

  has_many :seniors, class_name: 'Appointment', foreign_key: 'senior_id'
  has_many :companions, class_name: 'Appointment', foreign_key: 'companion_id'
  has_many :reviews
  has_many :reviewers, class_name: 'Review', foreign_key: 'reviewer_id'
  has_many :available_days

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 },allow_nil: true
  has_secure_password
  validate  :avatar_size

  # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:avatar, "should be less than 5MB")
      end
    end
end
