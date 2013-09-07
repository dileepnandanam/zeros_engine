class SessionsController < ApplicationController
  def new
  end

  def destroy
  end

  def create
    user = User.find_by_login(params[:login])
    respond_to do |format|
      if user && user.authenticate?(params[:password])
        sign_in(user)
        format.html {redirect_to sessions_new_path}
        format.json {render json: user}
      else
        format.html {redirect_to sessions_new_path}
        format.json {render json: user, status: :unprocessable_entity}
      end
  	end
  end
end
