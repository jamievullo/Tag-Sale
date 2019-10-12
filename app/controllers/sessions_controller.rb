class SessionsController < ApplicationController
    
    def new
    end 

    def create
        #byebug
        @user = User.find_by(name: params[:name])
        
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            render 'new'
        end     
    end

    def destroy
        session.clear
        redirect_to '/'
    end 

    private

    # def user_params
    #     params.require(:user).permit(:name, :password)
    # end 
end
