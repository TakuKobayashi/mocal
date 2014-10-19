# coding: utf-8
class Api::SpeechesController < Api::BaseController
  before_filter :load_event, only: [:speak, :stop]

  def start
    @event = @user.events.create!(type: "SpeechRecognize", status: :active, token: SecureRandom.hex)
  end

  def speak
    @sentence = @event.record!(JSON.parse(params[:recognized]) , params[:language_code])
    @sentence.analyze!
  end

  def stop
  	@event.complete!
  end

  private
  def load_event
  	@event = @user.events.where(token: params[:token]).first
  end
end
