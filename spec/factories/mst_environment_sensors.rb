# == Schema Information
#
# Table name: mst_environment_sensors
#
#  id         :integer          not null, primary key
#  senser_id  :string(255)      not null
#  place_name :string(255)
#  prefecture :string(255)
#  city       :string(255)
#  lat        :float(24)        default(0.0), not null
#  lon        :float(24)        default(0.0), not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_mst_environment_sensors_on_lat_and_lon  (lat,lon)
#  index_mst_environment_sensors_on_senser_id    (senser_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mst_environment_sensor, :class => 'Mst::EnvironmentSensor' do
  end
end
