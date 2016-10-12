class PostsController < ApplicationController
	before_action :find_post, :only => [:show, :destroy, :edit, :update, :like]
	before_action :authenticate_user! , :only => [:create, :new, :destroy, :edit, :update]
	before_action :owned_post, only: [:edit, :update, :destroy]  


	def index
		@posts = Post.all.order('created_at DESC').page params[:page]
	end

	def new
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build(posts_params)
		if @post.save
			flash[:success] ="Your post has been created!"
			redirect_to @post
	      else
      			flash.now[:alert] ="Your post could not be created! Please check the form"
	    		render :new
	      end	
	end

	def show
	end

	def edit
	end

	def update
		if @post.update(posts_params)
			flash[:success] ="Your post has been updated!"
			redirect_to post_path(@post)
	  	else
	  		flash.now[:alert] ="Update failed! Please check the form"
	   		render :edit
	  	end  		
	end

	def destroy
		if @post.destroy
			redirect_to posts_path
	  	else
	   		flash.now[:alert] ="Your post could not be created! Please check the form"
	  	end 		
	end
     
      def like
	      	if @post.liked_by current_user
	      		respond_to do |format|
	      			format.html { redirect_to :back}
	      			format.js
	      		end
	      end
	end

	private 

	def posts_params
		params.require(:post).permit(:image, :caption)
	end

	def owned_post  
	  	unless current_user == @post.user
	       	flash[:alert] = "That post doesn't belong to you!"
	      		redirect_to root_path
	  	end
  	end  

	def find_post
		@post = Post.find(params[:id])
	end
end
