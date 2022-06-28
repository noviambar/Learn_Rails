class Article < ApplicationRecord
  has_many :comments
 
  
  validates :title, presence: true
  validates :body, presence: true, length: {minimum: 10 }
  
  def self.search(params)
    if params[:status] == "true"
      article = self.where(['status LIKE ?', true])
    elsif params[:status] == "false"
      article = self.where(['status LIKE ?', false])
    elsif params[:title]
      article = self.where(['title LIKE ?', "%#{params[:title]}%"])
    else
      self.all
    end
  end
end
