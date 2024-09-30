class BookmarksController < ApplicationController
  before_action :set_category

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmarks.new(bookmark_params)
    @bookmark.category = @category
    if  @bookmark.save
      redirect_to category_path(@category)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment)
  end
end
