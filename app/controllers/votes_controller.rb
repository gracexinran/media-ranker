class VotesController < ApplicationController
  
  def upvote
    if session[:user_id]
      @vote = Vote.find_by(work_id: params[:id], user_id: session[:user_id])
      
      if @vote
        flash[:warning] = "A problem occurred: Could not upvote twice!"
      else
        @vote = Vote.new(work_id: params[:id], user_id: session[:user_id])
        
        if @vote.save
          flash[:success] = "Successfully upvoted!"
        else
          flash[:warning] = "A problem occurred: Could not upvote!" 
        end

      end
      
    else
      flash[:warning] = "A problem occurred: You must log in to do that!"
    end
    
    return redirect_to work_path(params[:id])
    
  end
  
end
