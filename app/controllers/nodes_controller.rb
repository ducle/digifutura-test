class NodesController < ApplicationController
  layout 'landing'

  def index
    @nodes = FileNode.roots.page(params[:page])
  end

  def show
  end


  def create

  end

  
end
