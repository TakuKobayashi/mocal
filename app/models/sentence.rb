# == Schema Information
#
# Table name: sentences
#
#  id               :integer          not null, primary key
#  source_type      :string(255)      not null
#  source_id        :integer          not null
#  origin_sentence  :text
#  fixture_sentence :text
#  status           :integer          not null
#  language_code    :string(255)      not null
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_sentences_on_source_type_and_source_id  (source_type,source_id)
#  index_sentences_on_status                     (status)
#

class Sentence < ActiveRecord::Base
  belongs_to :user
  belongs_to :source, :polymorphic => true
  has_many :sentence_candidates
  has_many :dependencies
  has_many :morphological_analysis
  has_many :fixture_sentences
  has_many :key_phrases

  enum status: [
    :initialize,
    :analized,
    :fixed
  ]

  def analyze!
    request_result = Mst::YahooApi.request_text_analize_api(self.origin_sentence)
    request_result.each do |key, values|
      next if values.blank?
      if key == "dependency"
        values.each do |list|
          morpheme_list = []
          list.each do |hash|
            morpheme_list << self.morphological_analysis.new(hash)
          end
          dependency = self.dependencies.create!(word: morpheme_list.map(&:surface).join(""))
          morpheme_list.each{|morpheme| morpheme.dependency_id = dependency.id }
          MorphologicalAnalysis.import(morpheme_list)
        end
      else
        import_list = []
        values.each do |value|
          import_list << self.send(key.pluralize).new(value)
        end
        key.classify.constantize.import(import_list)
      end
    end
    self.reload
    self.analized!
  end
end
