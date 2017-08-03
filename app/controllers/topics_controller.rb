class TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only:[:edit, :update, :destroy]
  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topics_params)
    @topic.user_id = current_user.id
    if @topic.save
      redirect_to root_path, notice: "作品を投稿しました。" # rootにしているので
    else
      render 'new'
    end
  end

  def show
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
