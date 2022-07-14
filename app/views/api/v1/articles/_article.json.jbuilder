json.id article.id

json.user do
  json.id article.id
  json.title article.title
  json.body article.body
  json.user_id article.user.name
end

json.created_at article.created_at