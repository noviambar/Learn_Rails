class User < ApplicationRecord
  has_many :article
  has_one :role

  validates :name, presence: true
  validates :phone, presence: true, numericality: true
  validates :email, presence: true, format: {with: URI::MailTo::EMAIL_REGEXP}

  has_secure_password
end
