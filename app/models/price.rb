# == Schema Information
#
# Table name: prices
#
#  id             :integer          not null, primary key
#  mst_company_id :integer          not null
#  price          :float(24)        default(0.0), not null
#  reported_at    :datetime         not null
#  created_at     :datetime
#  updated_at     :datetime
#
# Indexes
#
#  index_prices_on_mst_company_id  (mst_company_id)
#  index_prices_on_reported_at     (reported_at)
#

class Price < ActiveRecord::Base
  belongs_to :mst_company, class_name: "Mst::Company", foreign_key: :mst_company_id

  def self.import_company_articles!
    mst_companies = Mst::Company.where(id: Price.pluck(:mst_company_id).uniq)
    mst_companies.each do |mst_company|
      articles = Mst::AsahiApi.generate_articles!(mst_company)
    end
  end
end
