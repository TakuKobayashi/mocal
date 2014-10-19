# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  type       :string(255)      not null
#  status     :integer          not null
#  token      :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_events_on_token                        (token) UNIQUE
#  index_events_on_user_id_and_type_and_status  (user_id,type,status)
#

class SpeechRecognize < Event
  def record!(attributes, language_code)
    attribute = attributes.max_by{|attribute| attribute[:confidence].to_i}
    sentence = self.sentences.new(origin_sentence: attribute[:candidate], language_code: language_code)
    sentence.status = :initialize
    sentence.save!
    import_list = []
    attributes.each do |candidate|
      import_list << sentence.sentence_candidates.new(candidate)
    end
    SentenceCandidate.import(import_list)
    return sentence
  end
end
