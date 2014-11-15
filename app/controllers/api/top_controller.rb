# coding: utf-8
class Api::TopController < Api::BaseController

  def asahi
    @companies = Mst::Company.where("name like '%" + URI.decode(params[:q]) + "%'")
    if @companies.length >= 1
      @company = @companies[0]
    end
  end

  def companyDetail
    @companies = Mst::Company.where("name like '%" + URI.decode(params[:q]) + "%'")
    if @companies.length >= 1
      @company = @companies[0]
    end
  end

  def social
    @companies = Mst::Company.where("name like '%" + URI.decode(params[:q]) + "%'")
    if @companies.length >= 1
      @company = @companies[0]
    end
  end
end
