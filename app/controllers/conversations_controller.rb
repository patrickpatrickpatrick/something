class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    @opponent = User.find(conversation_params[:recipients].last)
    conv_check_1 = Mailboxer::Conversation.participant(@opponent)
    conv_check_2 = Mailboxer::Conversation.participant(current_user)
    @dialog = (conv_check_1 & conv_check_2).first
    if @dialog.nil? or !@dialog.is_participant?(current_user)
       conversation = current_user.send_message(@opponent, conversation_params[:body], conversation_params[:subject]).conversation
       flash[:success] = "Your message was successfully sent!"
       redirect_to conversation_path(conversation)
    else
      current_user.reply_to_conversation(@dialog, conversation_params[:body])
      flash[:notice] = "Your reply message was successfully sent!"
      redirect_to conversation_path(@dialog)
    end
  end

  def show
	  @receipts = conversation.receipts_for(current_user)
    conversation.mark_as_read(current_user)
  end

  def reply
    current_user.reply_to_conversation(conversation, message_params[:body])
    flash[:notice] = "Your reply message was successfully sent!"
    redirect_to conversation_path(conversation)
  end

  def trash
    conversation.receipts_for(current_user).update_all(:deleted => true)
    redirect_to mailbox_inbox_path
  end


  private

  def conversation_params
    params.require(:conversation).permit(:subject, :body, recipients:[])
  end

  def message_params
    params.require(:message).permit(:body, :subject)
  end

end
