# == Schema Information
#
# Table name: mst_companies
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Mst::Company < ActiveRecord::Base

end
