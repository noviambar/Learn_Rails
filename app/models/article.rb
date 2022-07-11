class Article < ApplicationRecord
  has_many :comment
  belongs_to :user

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

  def self.import(attachment)
    spreadsheet = self.open_spreadsheet(attachment)
    if spreadsheet
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        begin
          row = Hash[[header, spreadsheet.row(i)].transpose]
          self.find_or_create_item(row)
        rescue => e
          Rails.logger.info "Error when importing : #{e.inspect}"
        end
      end
    else
      false
    end
  end

  def self.find_or_create_item(row)
    article = Article.where("title like ?", row['title']).last || Article.new
    article.title = row['title']
    article.body = row['body']
    article.save
  end
    
  def self.open_spreadsheet(attachment)
    if attachment.present?
      case File.extname(attachment.original_filename)
      when ".csv" then Roo::CSV.new(attachment.path, nil, :ignore)
      when ".xls" then Roo::Excel.new(attachment.path, nil, :ignore)
      when ".xlsx" then Roo::Excelx.new(attachment.path, packed: false, file_warning: :ignore)
      else
        raise "Unknown file type: #{attachment.original_filename}"
      end
    else
      false
    end
  end
end
