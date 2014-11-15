json.positiveArticle do
  json.(@company.positiveArticle, :title, :body)
end
json.negativeArticle do
  json.(@company.negativeArticle, :title, :body)
end

json.(@company.positiveWord, :positiveWord)
json.(@company.negativeWord, :negativeWord)
