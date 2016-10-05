class PostsController < ApplicationController
	before_action :find_post, :only => [:show, :destroy, :edit, :update]
	def index
		@posts = Post.all
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(posts_params)
		if @post.save
			redirect_to @post
	  else
	   render "new"	
	  end	
	end

	def show
	end

	def edit
	end

	def update
		if @post.update(posts_params)
			redirect_to post_path(@post)
	  else
	    "edit"
	  end  		
	end

	def destroy
		if @post.destroy
			redirect_to posts_path
	  else
	   flash[:error] = "could not delete the photo"
	  end 		
	end

	private 

	def posts_params
		params.require(:post).permit(:image, :caption)
	end

	def find_post
		@post = Post.find(params[:id])
	end

end
