json.pagination do
  json.current_page @articles.current_page
  # json.per_page @articles.per_page
  json.total_pages @articles.total_pages
end

json.article @articles, partial: 'api/v1/articles/article', as: :article
# json.articles @articles do |article|
#   json.id article.id

#   json.user do 
#     json.id article.id
#     json.title article.title
#     json.body article.body
#     json.user_id article.user.name
#   end

#   # json.content article.content
#   json.created_at article.created_at
# end