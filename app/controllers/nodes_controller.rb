class NodesController < ApplicationController
  layout 'landing'

  def index
    @nodes = FileNode.roots.page(params[:page])
  end

  def show
  end


  def create

  end

  def upload
    puts params.inspect
  end

end
