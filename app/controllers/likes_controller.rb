class LikesController < ApplicationController

    def create
        idea = Idea.find(params[:id])
        if idea.users.include? current_user
            flash[:errors] = ["You can only like once"]
            return redirect_to :back
        end
        Like.create(user: current_user, idea: idea )
        return redirect_to :back
    end

end
