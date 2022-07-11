class Article < ApplicationRecord
  has_many :comment
  belongs_to :user, optional: true

  validates :title, presence: true
  validates :body, presence: true, length: {minimum: 10 }
  
  #untuk melakukan pencarian
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
    # spreadsheet = self.open_spreadsheet(attachment)
    # if spreadsheet
    #   header = spreadsheet.row(1)
    #   (2..spreadsheet.last_row).each do |i|
    #     begin
    #       row = Hash[[header, spreadsheet.row(i)].transpose]
    #       self.find_or_create_item(row)
    #     rescue => e
    #       Rails.logger.info "Error when importing : #{e.inspect}"
    #     end
    #   end
    # else
    #   false
    # end
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
