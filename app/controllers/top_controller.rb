# coding: utf-8
class TopController < BaseController
  def index
    gon.companies = Mst::Company.all.map do |mst_company|
      "#{mst_company.name} (#{mst_company.category_code}, #{mst_company.stock_code})"
    end
    gon.social_path = social_api_top_path
    gon.asahi_path = asahi_api_top_path
    gon.company_detail_path = company_detail_api_top_path
  end
end
