class Article < ApplicationRecord
  has_many :comment
  belongs_to :user, optional: true

  validates :title, presence: true
  validates :body, presence: true, length: {minimum: 10 }
  
  #untuk melakukan pencarian
  def self.search(params)
    if params[:status] == "Publish"
      article = self.where(['status LIKE ?', "Publish"])
    elsif params[:status] == "Unpublish"
      article = self.where(['status LIKE ?', "Unpublish"])
    elsif params[:title]
      article = self.where(['title LIKE ?', "%#{params[:title]}%"])
    else
      self.all
    end
  end

  #untuk import file CSV dan Excel
  def self.import(attachment, user)
    spreadsheet = open_spreadsheet(attachment)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      article = find_by_id(row["id"]) || new
      article.attributes = row.to_hash.slice(*row.to_hash.keys)
      article.user = user
      article.save!
    end
  end

  def self.find_or_create_item(row)
    article = Article.where("title like ?", row['title']).last || Article.new
    article.title = row['title']
    article.body = row['body']
    article.save
  end
    
  def self.open_spreadsheet(attachment)
      case File.extname(attachment.original_filename)
      when ".csv" then Roo::CSV.new(attachment.path, nil, :ignore)
      when ".xls" then Roo::Excel.new(attachment.path, nil, :ignore)
      when ".xlsx" then Roo::Excelx.new(attachment.path, packed: false, file_warning: :ignore)
      else
        false
      end
  end
end
