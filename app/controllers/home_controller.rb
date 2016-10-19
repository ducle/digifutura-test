class HomeController < ApplicationController

  def labels
    @nodes = current_user.my_files
    if params[:tags] && params[:tags].length > 0
      @nodes = @nodes.tagged_with(params[:tags])
    end
    @nodes = @nodes.page(params[:page])
  end
end
