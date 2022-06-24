class Article < ApplicationRecord

  
  has_many :comments

  validates :title, presence: true
  validates :body, presence: true, length: {minimum: 10 }
  
  def self.search(search)
    if search[:status] == "true"
      article = Article.where(['status LIKE ?', true])
    elsif search[:status] == "false"
      article = Article.where(['status LIKE ?', false])
    elsif search[:title]
      article = Article.where(['title LIKE ?', "%#{search[:title]}%"])
    else
      Article.all
    end
  end
end
