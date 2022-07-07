class User < ApplicationRecord
  belongs_to :role
  has_many :articles

  #nested attribtes
  has_many :socials, dependent: :destroy
  accepts_nested_attributes_for :socials, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true
  validates :mobile, presence: true, uniqueness: true, numericality: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  #using bcrypt
  has_secure_password

  #upload image
  mount_uploader :avatar, AvatarUploader
end
