class IdeasController < ApplicationController
  before_action :auth, only: [:destroy]
  def index
    @user = current_user
    # @ideas = Idea.all
    # @ideas = Idea.joins(:likes).group("ideas.id").order("COUNT(likes) DESC")
    @ideas = Idea.joins("LEFT OUTER JOIN likes ON likes.idea_id = ideas.id ").group("ideas.id").order("COUNT(likes) DESC")
    # @ideas = Idea.select("ideas.*, COUNT(likes.id) AS likes_count").joins("LEFT OUTER JOIN likes ON like.id = ideas.like_id ").group("ideas.id").order("likes_count DESC")
    # @ideas = Idea.joins(:users).group("user")
  end

  def create
    idea = Idea.new(idea_params)
    idea.user = current_user
    unless idea.save
      flash[:errors] = idea.errors.full_messages
    end
    return redirect_to :back
  end

  def show
    @user = current_user
    @idea = Idea.find(params[:id])
    @users = @idea.users
  end

  def destroy
    Idea.find(params[:id]).destroy
    return redirect_to :back
  end

  private
    def idea_params
      params.require(:idea).permit(:content)
    end

    def auth
      return redirect_to '/bright_ideas' unless session[:user_id] == Idea.find(params[:id]).user.id
    end

end
