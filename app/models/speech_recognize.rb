# == Schema Information
#
# Table name: speech_recognizes
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  status     :integer          not null
#  token      :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_speech_recognizes_on_token               (token) UNIQUE
#  index_speech_recognizes_on_user_id_and_status  (user_id,status)
#

class SpeechRecognize < ActiveRecord::Base
  belongs_to :user
  has_many   :sentences, as: :source
  has_many   :sent_logs

  enum status: [
    :active,
    :complete
  ]

  def record!(attributes, language_code)
    attribute = attributes.max_by{|attribute| attribute[:confidence].to_i}
    sentence = self.sentences.new(user_id: self.user_id, origin_sentence: attribute[:candidate], language_code: language_code)
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
