class CommentsController < ApplicationController
  skip_before_action :restrict_access, only: :index
  before_action :set_article

  def index
    @comments = @article.comments.preload(:user).
      page(params[:page]).per(params[:per_page])

    render json: @comments, include: CommentSerializer::INCLUDED
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: @comment, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private
    def set_article
      @article = Article.find(params[:article_id])
    end

    def comment_params
      params.require(:comment).permit(:content, :article_id, :user_id)
    end
end
