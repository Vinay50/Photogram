class ProfilesController < ApplicationController
	before_action :owned_profile, only: [:edit, :update]
	before_action  :authenticate_user! 
	before_action :set_user

	def show
	  	@posts = User.find_by(username: params[:username]).posts.order("created_at DESC")
	end

	def edit
	end

	def update
	 	if@user.update(user_profile)
	 	 	flash[:success] = "Your profile has been updated"
	 	 	redirect_to profile_path(@user.username)
	 	else
	 		flash[:error] = @user.errrors.full_messages 
	 		render :edit
	 	end	
	end

	private

      def set_user  
            @user = User.find_by(username: params[:username])
       end

      def owned_profile  
      	     @user = User.find_by(username: params[:username])
	      unless current_user == @user
	           flash[:alert] = "That profile doesn't belong to you!"
	           redirect_to root_path
	    end
      end

	def user_profile  
	 	params.require(:user).permit(:avatar, :bio)
	end  
end
