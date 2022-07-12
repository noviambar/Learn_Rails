class User < ApplicationRecord
  belongs_to :role
  has_many :articles

  #nested attribtes
  has_many :socials, dependent: :destroy
  accepts_nested_attributes_for :socials, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true, uniqueness: true
  validates :mobile, presence: true, uniqueness: true, numericality: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :avatar, file_size: { less_than: 1.megabytes, message: "Image should be less than 1MB"}

  #using bcrypt
  has_secure_password

  #upload image
  mount_uploader :avatar, AvatarUploader
end
