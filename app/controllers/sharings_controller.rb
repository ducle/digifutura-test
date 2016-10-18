class SharingsController < ApplicationController

  def index
    @nodes = FileNode.roots.page(params[:page])
  end

  def show
    @file_node = my_nodes.find(params[:id])
    @nodes = @file_node.children.by_name.page(params[:page])
  end



end
