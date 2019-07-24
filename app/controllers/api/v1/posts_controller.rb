module Api
  module V1
    class PostsController < Api::V1::ApiController
      before_action :doorkeeper_authorize!
      before_action :find_post, only: %i[update]

      def index
        posts = Post.only_posts
        render json: posts
      end

      def create
        @post = current_user.posts.new(post_params)
        if @post.save
          render json: { post: @post }, status: :created
        else
          render json: { message: @post.errors.full_messages }
        end
      end

      def show
        @post = Post.friendly.find(params[:id])
        render json: @post, include: [:answers]
      end
       
      def update
        if @post.update(post_params)
          render json: { message: 'Updated Successfully' }, status: :ok
        else
          render json: { message: @post.errors.full_messages },status: :error
        end
      end

      private

      def find_post
        @post = current_user.posts.friendly.find(params[:id])
      end
      
      def post_params
        params.permit(:title, :slug, :description, :user_id, :account_id, :post_id, tags_attributes: [:id, :name, :_destroy])
      end
      
    end
  end
end
