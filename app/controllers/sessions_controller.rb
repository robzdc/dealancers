class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url
  end

  def destroy
        session[:user_id] = nil
        redirect_to root_url, :notice => "Signed out!"
  end

  def omniauth_failure
    redirect_to root_url, :notice => "Error Sign in!"
    #redirect wherever you want.
  end

end