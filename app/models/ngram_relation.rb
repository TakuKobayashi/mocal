class NgramRelation < ActiveRecord::Base
  belongs_to :ngram
  belongs_to :source, :polymorphic => true
end
