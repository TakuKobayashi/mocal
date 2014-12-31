# == Schema Information
#
# Table name: environment_data
#
#  id                        :integer          not null, primary key
#  mst_environment_sensor_id :integer          not null
#  data_category             :integer          not null
#  obs_datetime              :datetime         not null
#  val                       :float(24)        not null
#  created_at                :datetime
#  updated_at                :datetime
#
# Indexes
#
#  index_environment_data_on_mst_environment_sensor_id  (mst_environment_sensor_id)
#  index_environment_data_on_obs_datetime               (obs_datetime)
#

class EnvironmentData < ActiveRecord::Base
  def self.import_data(mst_environment_sensor, data)
    array = data["environment_data"]
    data_list = []
    array.each do |cell|
      unless mst_environment_sensor.environment_data.where("obs_datetime >= ?", cell["obs_datetime"]).exists?
      	cell["val"].each do |val|
          data_list << mst_environment_sensor.environment_data.new(obs_datetime: cell["obs_datetime"], data_category: cell["data_type"], val: val)
        end
      end
    end
    EnvironmentData.import(data_list)
  end
end
