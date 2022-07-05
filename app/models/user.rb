class User < ApplicationRecord
  belongs_to :role
  has_many :articles

  validates :name, presence: true
  validates :mobile, presence: true, uniqueness: true, numericality: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_secure_password
end
