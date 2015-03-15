# == Schema Information
#
# Table name: sounds
#
#  id               :integer          not null, primary key
#  wav_file_path    :string(255)      not null
#  file_type        :string(255)      not null
#  original_name    :string(255)      not null
#  millisecond_time :integer          default(0), not null
#  options          :text
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_sounds_on_original_name  (original_name)
#

require 'rails_helper'

RSpec.describe Sound, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
