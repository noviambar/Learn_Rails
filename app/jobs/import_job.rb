class ImportJob < ApplicationJob
  queue_as :default

  def open_spreadsheet(attachment)
    case File.extname(attachment.original_filename)
    when ".csv" then Roo::CSV.new(attachment.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(attachment.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(attachment.path, packed: false, file_warning: :ignore)
    else
      false
    end
  end

  def find_by_id(row)
    article = Article.where("id like ?", row["id"]).last || Article.new
  end

  def perform(attachment, user)
      spreadsheet = open_spreadsheet(attachment)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        article = find_by_id(row) || new
        article.attributes = row.to_hash.slice(*row.to_hash.keys)
        article.user = user
        article.save!
      end
  end
end