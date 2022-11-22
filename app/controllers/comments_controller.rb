# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show destroy]

  # GET /comments/1
  def show; end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    @comment[:user_id] = current_user.id
    @comment[:commentable_id] = @commentable.id
    @comment[:commentable_type] = @commentable.class

    if @comment.save
      redirect_to [@commentable], notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy

    redirect_to @commentable, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find_by!(id: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:user_id, :content, :commentable_type, :commentable_id)
  end
end
