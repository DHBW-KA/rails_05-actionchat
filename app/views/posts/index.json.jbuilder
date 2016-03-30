json.array!(@posts) do |post|
  json.extract! post, :id, :user, :content
  json.url post_url(post, format: :json)
end
