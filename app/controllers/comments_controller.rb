class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[ new edit update destroy ]
  before_action :set_post
  before_action :set_comment, only: %i[ destroy edit update show ]

  def show
  end

  def create
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend("comments-list", partial: "comment", locals: { comment: @comment })
          ]
        format.html { redirect_to user_post_path(@post.user, @post), notice: "Comment was successfully created." }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to user_post_path(@post.user, @post), notice: "Comment was successfully updated" }
        format.json { render user_post_path(@post.user, @post), status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    comment_id = @comment.id
    @comment.destroy!

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove("comment_#{comment_id}")
      end
      format.html { redirect_back_or_to root_path, status: :see_other, notice: "Comment deleted" }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:post_id])
    end

    def set_comment
      @comment = @post.comments.find_by(id: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.expect(comment: [ :content ])
    end
end
