class Article < ApplicationRecord

  include ArticleSearch

  has_many :comment
  belongs_to :user, optional: true

  validates :title, presence: true
  validates :body, presence: true, length: {minimum: 10 }

  def self.open_spreadsheet(attachment)
    if attachment.present?
      # debugger
      case File.extname(attachment.original_filename)
      when ".csv" then Roo::CSV.new(attachment.path, nil, :ignore)
      when ".xls" then Roo::Excel.new(attachment.path, nil, :ignore)
      when ".xlsx" then Roo::Excelx.new(attachment.path, packed: false, file_warning: :ignore)
      else
        false
      end
    else
      false
    end
  end
end
