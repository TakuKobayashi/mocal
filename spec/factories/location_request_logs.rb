# == Schema Information
#
# Table name: location_request_logs
#
#  id            :integer          not null, primary key
#  relation_type :string(255)
#  relation_id   :integer
#  address       :string(255)
#  latitude      :float(24)        not null
#  longitude     :float(24)        not null
#  elevation     :float(24)
#  ip_address    :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_location_request_logs_on_ip_address                     (ip_address)
#  index_location_request_logs_on_relation_type_and_relation_id  (relation_type,relation_id)
#  lat_lon_ele_index                                             (latitude,longitude,elevation)
#

FactoryGirl.define do
  factory :location_request_log do
    
  end

end
