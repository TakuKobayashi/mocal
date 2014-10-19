# coding: utf-8
class CommentsController < BaseController
  before_filter :load_user

  def new
  end

  def input
    @comment = @user.comments.find_or_create_by(token: params[:token])
    @sentence = @comment.sentences.new(user_id: @user.id, origin_sentence: params[:sentence], language_code: params[:language_code])
    @sentence.status = :initialize
    @sentence.save!
    @sentence.analyze!
    @collected_data = setup_data(@comment.sentences.pluck(:id))
  end

  private
  def load_user
    @user = User.where(name: "iii",auth_token: "aaa").first_or_create
    redirect_to root_url if @user.blank?
  end

  def setup_data(sentence_ids)
  	result = {}
  	#頻出するワード上位5件
    result[:frequentWordCount] = MorphologicalAnalysis.
                         where(sentence_id: sentence_ids, pos: "名詞").
                         group("surface").
                         order("COUNT(surface) DESC").
                         limit(5).count
    result[:totalWordCount] = MorphologicalAnalysis.where(sentence_id: sentence_ids, pos: "名詞").count
    score_list = KeyPhrase.where(sentence_id: sentence_ids).group(:keyphrase).average(:score)
    count_list = KeyPhrase.where(sentence_id: sentence_ids).group(:keyphrase).count
    calc_list = score_list.inject({}) do |diff , (key, value)|
      diff[key] = value * count_list[key].to_i
      diff
    end
    list = calc_list.sort_by{|key, value| -value}.transport
    result[:totalKeyPhraseScore] = list[1].sum
    result[:highKeyPhraseScore] = Hash[*[list[0][0..4], list[1][0..4]].transport.flatten]
    return result
  end
end
