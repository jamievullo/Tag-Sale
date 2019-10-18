class UsersController < ApplicationController

    def index 
        @users = User.all
    end

    def new 
        @user = User.new
    end

    def create 
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user), notice: "User Created!"
        else           
            render :new
        end
    end

    def show 
        @user = User.find(params[:id])
        #render :show
    end

    private 

    def user_params
        params.require(:user).permit(:name, :email, :password, :location, :uid)
    end
end
