# == Schema Information
#
# Table name: mst_api_feature_configs
#
#  id                     :integer          not null, primary key
#  mst_api_config_id      :integer          not null
#  category               :integer          not null
#  request_url            :string(255)      not null
#  request_format         :integer          not null
#  limit_count            :integer
#  limit_request_capacity :integer
#  limited_at             :datetime
#  created_at             :datetime
#  updated_at             :datetime
#
# Indexes
#
#  mst_api_feature_configs_request_index  (mst_api_config_id,category,request_url) UNIQUE
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mst_api_feature_config, :class => 'Mst::ApiFeatureConfig' do
  end
end
