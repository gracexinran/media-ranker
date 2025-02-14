class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      head :not_found
      return
    end
  end

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    found_user = User.find_by(username: username)

    if found_user
      session[:user_id] = found_user.id
      flash[:success] = "Successfully logged in as existing user #{found_user.username}"
    else
      @user = User.new(username: username)
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "Successfully created new user #{@user.username} with ID #{@user.id}"
      else
        flash.now[:warning] = "A problem occurred: Could not create user"
        render :login_form
        return
      end
    end

    return redirect_to root_path
    
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    return redirect_to root_path
  end
  
end
