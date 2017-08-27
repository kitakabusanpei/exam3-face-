class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    # 会話にひもづくメッセージを取得
    @messages = @conversation.messages
    # メッセージを１０まで表示、１０より大きければ最新の１０に絞る
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end

    # 最新のメッセージが自分のユーザーIDでなければ最新のメッセージを既読にする
    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end

    if @messages.last # lastメソッド配列の最後の要素を返しからの時はnilを返す
      if @messages.last.user_id != current_user.id
        @messages.last.read = true
      end
    end

    # 新規投稿のメッセージ用の変数を作成する
    @message = @conversation.messages.build
  end

  def create
    # HTTPリクエスト上のパラメーターを利用して会話にひもづくメッセージを作成
    @message = @conversation.messages.build(message_params)
    # 保存できれば、会話にひもづくメッセージ一覧の画面に遷移する
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private
    def message_params
      params.require(:message).permit(:body, :user_id)
    end
end
