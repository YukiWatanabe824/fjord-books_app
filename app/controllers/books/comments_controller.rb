class Book::CommentsController < BooksController
  before_action :set_commentable, only: %i[create]
  private
  def set_commentable
    @commentable = Book.find(params[:id])
  end
end
