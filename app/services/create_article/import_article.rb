module CreateArticle
  class ImportArticle     
    # #untuk import file Excel

    def initialize(attachment, user, original_filename)
      attachment = attachment
      user       = user
    end

    attr_accessor :attachment, :user

    def self.import(attachment, user)
      spreadsheet = Article.open_spreadsheet(attachment)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        article = find_by_id(row) || new
        article.attributes = row.to_hash.slice(*row.to_hash.keys)
        article.user = user
        article.save!
      end
    end

    def self.find_by_id(row)
      article = Article.where("id like ?", row["id"]).last || Article.new
    end

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
end