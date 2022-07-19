class ExportJob
  include Sidekiq::Job

  Sidekiq::Stats.new.reset

  def perform
    articles = Article.all

    xlsx_package = Axlsx::Package.new
    wb = xlsx_package.workbook

    wb.add_worksheet(name: "Articles") do |sheet|
      # this is the head row of your spreadsheet
      sheet.add_row %w(id title body user_id status)
      
      # each user is a row on your spreadsheet
      articles.each do |article|
        sheet.add_row [article.id, article.title, article.body, article.user_id, article.status]
      end
    end
    
    # xlsx_package.serialize Rails.root.join("tmp", "articles_export_#{self.jid}.xlsx")
  end
end