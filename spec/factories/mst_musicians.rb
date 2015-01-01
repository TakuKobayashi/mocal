# == Schema Information
#
# Table name: mst_musicians
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  image_url  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :mst_musician, :class => 'Mst::Musician' do
    
  end

end
