# == Schema Information
#
# Table name: environment_data
#
#  id                        :integer          not null, primary key
#  mst_environment_sensor_id :integer          not null
#  data_type                 :integer          not null
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

require 'rails_helper'

RSpec.describe EnvironmentData, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
