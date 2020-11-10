class SessionsController < ApplicationController
    before_action :require_logged_in, only: %i[destroy]
    
    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.find_by_credentials(params[:user][:username],params[:user][:password])
        if @user
            login(@user)
            redirect_to users_url
        else
            flash.now[:errors] = ["Invalid credentials"]
            @user = User.new(username: params[:user][:username])
            render :new
        end
    end

    def destroy
        logout!
        redirect_to new_session_url
    end
end

