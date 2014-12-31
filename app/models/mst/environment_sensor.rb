# == Schema Information
#
# Table name: mst_environment_sensors
#
#  id         :integer          not null, primary key
#  sensor_id  :string(255)      not null
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
#  index_mst_environment_sensors_on_sensor_id    (sensor_id)
#

class Mst::EnvironmentSensor < ActiveRecord::Base
  has_many :environment_data, class_name: "EnvironmentData", foreign_key: "mst_environment_sensor_id"
  has_many :location_request_logs, as: :relation

  scope :range, ->(lat, lon, round){
    where(lat: (lat - round)..(lat + round), lon: (lon - round)..(lon + round))
  }

  def self.importApiData(data)
    array = data["sensor"]
    data_list = []
    array.each do |cell|
      unless Mst::EnvironmentSensor.exists?(sensor_id: cell["id"])
        data_list << Mst::EnvironmentSensor.new(sensor_id: cell["id"], place_name: cell["name"], prefecture: cell["prefecture"], city: cell["city"], lat: cell["lat"], lon: cell["lon"])
      end
    end
    Mst::EnvironmentSensor.import(data_list)
  end

  def self.nearest_sensor(lat, lon)
    nearest = Mst::EnvironmentSensor.all.min_by do |sensor|
      ((sensor.lat - lat)) ** 2 + ((sensor.lon - lon)) ** 2 
    end
    return nearest
  end
end
