class ImportJob
  include Sidekiq::Job

  Sidekiq::Stats.new.reset

  def perform(attachment, current_user)
    CreateArticle::ImportArticle.import(attachment, current_user)
  end

  # FIXME(ezekg) Remove after backlog for RequestLogWorker2 is clear 
  RequestLogWorker2 = RequestLogWorker 
end
