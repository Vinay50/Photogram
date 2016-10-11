class ProfilesController < ApplicationController
	def show
	  	@posts = User.find_by(username: params[:username]).posts.order("created_at DESC")
	  	@user = User.find_by(username: params[:username])
	end

	def edit
	 	@user = User.find_by(username: params[:username])
	end

	def update
	 	@user = User.find_by(username:params[:username])
	 	 if@user.update(user_profile)
	 	 	flash[:success] = "Your profile has been updated"
	 	 	redirect_to profile_path(@user.username)
	 	else
	 		flash[:error] = @user.errrors.full_messages 
	 		render :edit
	 	end	
	end

	private

	def profile_params  
	  params.require(:user).permit(:avatar, :bio)
	end  
end
