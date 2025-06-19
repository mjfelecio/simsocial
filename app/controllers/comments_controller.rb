class CommentsController < ApplicationController
  before_action :set_post

  def new
    @comment = @post.comments.build
  end

  def create
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to user_post_path(@post.user, @post), notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_post
      @post = Post.find(params[:post_id])
    end

    def set_comments
      @comments = @post.comments
      @comment = @comments.find_by(id: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.expect(comment: [ :content ])
    end
end
