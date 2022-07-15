class Article < ApplicationRecord

  include ArticleSearch

  has_many :comment
  belongs_to :user, optional: true

  validates :title, presence: true
  validates :body, presence: true, length: {minimum: 10 }

end
