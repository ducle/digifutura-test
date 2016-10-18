class SharingsController < ApplicationController

  def index
    @nodes = current_user.accessible_file_nodes.page(params[:page])
  end

  def show
    @file_node = FileNode.find(params[:id])
    unless @file_node.can_access_by_user?(current_user)
      redirect_to sharings_path and return
    end
    @nodes = @file_node.children.by_name.page(params[:page])
  end

end
