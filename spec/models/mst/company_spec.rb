# == Schema Information
#
# Table name: mst_companies
#
#  id            :integer          not null, primary key
#  name          :string(255)      not null
#  category_code :integer          not null
#  stock_code    :integer          not null
#  search_name   :string(255)      not null
#  created_at    :datetime
#  updated_at    :datetime
#

require 'rails_helper'

RSpec.describe Mst::Company, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
