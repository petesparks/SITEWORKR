class MessagesController < ApplicationController
  before_action do
    @match = Match.find(params[:match_id])
  end

  def index
    @messages = @match.messages
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end
    if params[:m]
      @over_ten = false
      @messages = @match.messages
    end
    if @messages.last
      if @messages.last.user_id != current_user.id
        @messages.last.read = true
      end
    end

    @message = @match.messages.new
  end

  def new
    @message = @match.messages.new
  end

  def create
    @message = @match.messages.new(message_params)
    if @message.save
      redirect_to match_path(@match)
    end
  end

private
  def message_params
    params.require(:message).permit(:body, :user_id)
  end
end
