# == Schema Information
#
# Table name: company_source_relations
#
#  id             :integer          not null, primary key
#  mst_company_id :integer          not null
#  source_type    :string(255)      not null
#  source_id      :integer          not null
#  created_at     :datetime
#  updated_at     :datetime
#
# Indexes
#
#  index_company_source_relations_on_mst_company_id             (mst_company_id)
#  index_company_source_relations_on_source_type_and_source_id  (source_type,source_id)
#

class CompanySourceRelation < ActiveRecord::Base
  belongs_to :source, :polymorphic => true
  belongs_to :mst_company
end
