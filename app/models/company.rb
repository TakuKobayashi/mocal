# == Schema Information
#
# Table name: companies
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
#  index_companies_on_mst_company_id  (mst_company_id)
#  index_companies_on_reported_at     (reported_at)
#

class Company < ActiveRecord::Base
  belongs_to :mst_company, class_name: "Mst::Company", foreign_key: :mst_company_id
end
