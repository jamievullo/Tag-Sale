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
            flash[:notice] = "Welcome #{@user.name}!"
            redirect_to user_path(@user)
        else  
            @errors = @user.errors.full_messages         
            render :new
        end
    end

    def show 
        @user = User.find(params[:id])
    end

    private 

    def user_params
        params.require(:user).permit(:name, :email, :password, :location, :uid)
    end
end
