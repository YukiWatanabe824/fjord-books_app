class CommentsController < ApplicationController
  before_action :set_book_or_report
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/1/edit
  def edit
    redirect_to comments_path if @comment.user.id != current_user.id
  end

  # POST /comments or /comments.json
  def create
    @comment = Comment.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to [@commentable], notice: t('controllers.common.notice_create', name: Comment.model_name.human) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comment_url(@comment), notice: t('controllers.common.notice_update', name: Comment.model_name.human) }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @commentable, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human) }
    end
  end

  private
    def set_book_or_report
      @commentable = if request.url.include?("reports")
                       Report.find(params[:report_id])
                     else
                       Book.find(params[:book_id])
                     end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find_by!(id: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:user_id, :content, :commentable_type, :commentable_id)
    end
end
