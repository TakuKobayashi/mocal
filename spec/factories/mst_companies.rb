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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mst_company, :class => 'Mst::Company' do
  end
end
