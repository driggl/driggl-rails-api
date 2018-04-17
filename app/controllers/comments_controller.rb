class CommentsController < ApplicationController
  skip_before_action :restrict_access, only: :index
  before_action :set_article

  def index
    @comments = @article.comments.preload(:user).
      page(params[:page]).per(params[:per_page])

    render json: @comments, include: CommentSerializer::INCLUDED
  end

  def create
    raise AccessDeniedError if @article.user != current_user
    @comment = @article.comments.build(comment_params)

    if @comment.save
      render json: @comment, status: :created, location: @article
    else
      render json: @comment, adapter: :json_api,
        serializer: ActiveModel::Serializer::ErrorSerializer,
        status: :unprocessable_entity
    end
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    h = params[:data]&.[](:attributes) || ActionController::Parameters.new
    h.merge(user_id: current_user.id).permit(:content, :user_id)
  end
end
