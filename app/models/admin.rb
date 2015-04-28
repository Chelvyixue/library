class Admin < ActiveRecord::Base
  before_save { self.email = email.downcase }

  has_many :records

  validates :name, presence: true, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

  has_secure_password
  validates :password, length: { minimum: 6 }
end
