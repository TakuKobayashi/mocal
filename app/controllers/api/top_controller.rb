# coding: utf-8
class Api::TopController < Api::BaseController

def asahi
  @companies = Mst::Company.where("name like '%" + params[:q] + "%'")

  #if (companies.length == 1){
  #  @company = @companies[0]
  #  json.positiveArticle do
  #    json.(@company.positiveArticle, :title, :body)
  #  end
  #  json.negativeArticle do
  #    json.(@company.negativeArticle, :title, :body)
  #  end

  #  json.(@company.positiveWord, :positiveWord)
  #  json.(@company.negativeWord, :negativeWord)
  #  json.(@compnay.)
  #}else {

  #}

end

def companyDetail
  @companies = Mst::Company.where("name like '%" + params[:q] + "%'")
  if @companies.length >= 1
    @company = @companies[0]
  end
end

def social

end

end
