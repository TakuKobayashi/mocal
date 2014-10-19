# coding: utf-8
class Api::SpeechesController < Api::BaseController
  before_filter :load_speech_recognize, only: [:speak, :stop]

  def start
    @speech_recognize = @user.speech_recognizes.create!(status: :active, token: SecureRandom.hex)
  end

  def speak
    @sentence = @speech_recognize.record!(JSON.parse(params[:recognized]) , params[:language_code])
    @sentence.analyze!
  end

  def stop
    @event.complete!
  end

  private
  def load_speech_recognize
    @speech_recognize = @user.speech_recognizes.where(token: params[:token]).first
  end
end
