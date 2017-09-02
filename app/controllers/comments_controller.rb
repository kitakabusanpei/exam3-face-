class CommentsController < ApplicationController
  before_action :set_comment, only:[:edit, :update, :destroy]
  # コメントを保存、投稿するためのアクション
  def create
    # topicをパラメータの値から探し出し,topic_idに紐づくcommentsとしてbuildします。
    @comment = current_user.comments.build(comment_params)
    @topic = @comment.topic
    # respond_to クライアント（ブラウザ）からの要求に応じて、異なるテンプレートを呼び出すメソッド
    # do ... endで囲む。ただし、クライアント側(View)は remote: true を定義しないといけない
    respond_to do |format|
      if @comment.save
        flash.now[:notice] = 'コメントを投稿しました。'
        format.html { redirect_to topic_path(@topic), notice: 'コメントを投稿しました。'}
        format.js { render :index }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @topic = @comment.topic
  end

  def update
    if @comment.update(comment_params)
      flash.now[:notice] = 'コメントを更新しました。'
      redirect_to topic_path(@comment.topic), notice: 'コメントを更新しました。'
    else
      render 'edit'
    end
  end

  def destroy
    @comment.destroy
    flash.now[:notice] = 'コメントを削除しました。'
    respond_to do |format|
      format.html { redirect_to topic_path(@topic), notice: 'コメント削除しました。' }
      format.js { render :index}
    end
  end

  private
   def comment_params
     params.require(:comment).permit(:topic_id, :content)
   end

   def set_comment
     @comment = Comment.find(params[:id])
   end
end

# binding.pry
