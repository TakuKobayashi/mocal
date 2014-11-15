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

require 'rails_helper'

RSpec.describe Company, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
