class SharingsController < ApplicationController

  def index
    @nodes = current_user.accessible_file_nodes.page(params[:page])
  end

  def show
    @file_node = FileNode.find(params[:id])
    unless current_user.can_access_node?(@file_node)
      redirect_to sharings_path and return
    end
    @nodes = @file_node.children.by_name.page(params[:page])
  end

end
