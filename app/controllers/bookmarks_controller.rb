class BookmarksController < ApplicationController
  before_action :set_list, only: [:create, :destroy]

  def create
    @bookmark = @list.bookmarks.new(bookmark_params)

    if @bookmark.save
      redirect_to list_path(@list), notice: 'Movie added to List Successfully.'
    else
      render 'lists/show', status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path, status: :see_other, notice: 'Bookmark removed.'
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end
end
