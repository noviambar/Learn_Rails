class User < ApplicationRecord
  belongs_to :role
  has_many :article

  validates :name, presence: true
  validates :phone, presence: true, numericality: true
  validates :email, presence: true, format: {with: URI::MailTo::EMAIL_REGEXP}

  has_secure_password
end
