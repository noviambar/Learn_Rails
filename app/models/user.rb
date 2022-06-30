class User < ApplicationRecord
  belongs_to :role
  has_many :articles
  has_many :roles
  accepts_nested_attributes_for :roles, allow_destroy: true

  validates :name, presence: true
  validates :phone, presence: true, numericality: true
  validates :email, presence: true, format: {with: URI::MailTo::EMAIL_REGEXP}

  has_secure_password
end
