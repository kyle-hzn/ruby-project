class PostsController < ApplicationController
    before_action :find_post, only: [:edit, :update, :show, :delete]
    before_action :authenticate_admin!
  
    # Index action to render all posts
    def index
      if params[:category].blank?
        @posts = Post.all.order("created_at DESC")
        else
        @category_id = Category.find_by(name: params[:category]).id
        @posts = Post.where(category_id: @category_id).order("created_at DESC")
      end
    end
  
    # New action for creating post
    def new
      @post = Post.new
    end
  
    # Create action saves the post into database
    def create
      @post = Post.new(post_params)

      if @post.save
         flash[:notice] = "Successfully created post!"
         redirect_to post_path(@post)
      else

         flash[:alert] = "Error creating new post!"
         render :new
      end
   end
  
    # Edit action retrives the post and renders the edit page
    def edit
      @post = Post.find(params[:id])
    end
  
    # Update action updates the post with the new information
    def update
      @post = Post.find(params[:id])
      
      if @post.update(post_params)
          redirect_to post_path(@post)
          # redirect_to(:action => 'posts#show')
      else
          render 'edit'
      end
    end
  
    # The show action renders the individual post after retrieving the the id
    def show
      @post = Post.find(params[:id])
    end
  
    # The destroy action removes the post permanently from the database
    def destroy
      @post = Post.find(params[:id])
      @post.destroy

      redirect_to posts_path
  end
  
    private
  
    def post_params
        params.require(:post).permit(:title, :body, :category_id)
    end
  
    def find_post
      @post = Post.find(params[:id])
    end
  end