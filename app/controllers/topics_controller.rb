class TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only:[:show, :edit, :update, :destroy]
  def index
    @topics = Topic.all.order(updated_at: :desc)
    @users = User.all
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topics_params)
    # 現在ログインしているユーザーのid(current_user.idのこと)をuser_id入れる
    # これでtopicとuserのアソシエーションをすることができる
    # ただしマイグレーションでtopicにuserのreferences型のカラムを作成していることが前提条件
    @topic.user_id = current_user.id
    if @topic.save
      redirect_to root_path, notice: "作品を投稿しました。" # rootにしているので
      NoticeMailer.sendmail_topic(@topic).deliver
    else
      render 'new'
    end
  end

  def show
    # buildでtopicにcommentsのtopic_idを持たせることができる
    # commentに関連性を持たせたインスタンスができる
    @comment = @topic.comments.build
    # topicのコメント
    @comments = @topic.comments
  end

  def edit
  end

  def update
    if @topic.update(topics_params)
      redirect_to root_path, notice: "作品を更新しました。" # rootにしているので
    else
      render 'edit'
    end
  end

  def destroy
    @topic.destroy
    redirect_to root_path, notice: "作品を削除しました。" # rootにしているので
  end

  private
  def topics_params
    params.require(:topic).permit(:content, :photo)
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end

end

# binding.pry
