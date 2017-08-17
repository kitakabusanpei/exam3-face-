class ConversationsController < ApplicationController
  before_action :authenticate_user!  # ログインしている時のみ有効
  def index
    @users = User.all
    @conversations = Conversation.all
  end

  # senderが送り主で`recipientが受取人
  def create
      # 過去の会話の確認
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      # 過去の会話の取得
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      # 会話がなかった場合、強制的に作成
      @conversation = Conversation.create!(conversation_params)
    end
    # 会話にひもづくメッセージの一覧画面へ背にさせるs式
    redirect_to converrsation_messages_path(@conversation)
  end

  private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end

end
