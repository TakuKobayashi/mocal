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

FactoryGirl.define do
  factory :company do
    
  end

end
