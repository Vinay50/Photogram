class PostsController < ApplicationController
	def index
		@posts = Post.all
	end

	def new
		@post = Post.new
	end

	def create
		#@post = Post.create(posts_params)
		@post = Post.new(posts_params)
		if @post.save
			redirect_to @post
	  else
	   render "new"	
	  end	
	end

	def show
		@post = Post.find(params[:id])
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private 

	def posts_params
		params.require(:post).permit(:image, :caption)
	end
	
end
