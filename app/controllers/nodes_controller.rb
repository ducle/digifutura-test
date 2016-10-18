class NodesController < ApplicationController

  def index
    @nodes = FileNode.roots.by_name.page(params[:page])
  end

  def show
    @file_node = FileNode.find(params[:id])
    @nodes = @file_node.children.by_name.page(params[:page])
  end

  def new
    @file_node = FileNode.folders.new(owner_id: current_user.id, parent_id: params[:parent_id])
  end

  def create
    @file_node = FileNode.folders.new(node_param)
    @file_node.owner_id = current_user.id
    if @file_node.save
      redirect_to nodes_path
    else
      render :new
    end
  end

  def upload
    @file_node = FileNode.files.new(owner_id: current_user.id)
    if params[:files] && file = params[:files].first
      @file_node.file = file
      @file_node.parent_id = params[:parent_id]
      @file_node.name = file.original_filename
      @file_node.file_size = file.size
    end
    if @file_node.save
      render json: {status: 'OK'}
    else
      render json: {status: 'ERROR', message: @file_node.errors.full_messages.join(', ')}
    end
  end


  def sharing
    @file_node = FileNode.find(params[:id])
  end

  def share
    @file_node = FileNode.find(params[:id])
    @file_node.user_ids = share_param[:user_ids]
    redirect_to node_path(@file_node.parent || @file_node)
  end

  private

  def node_param
    params.require(:file_node).permit(:name, :file, :parent_id)
  end

  def share_param
    params.require(:file_node).permit(:user_ids => [])
  end
end
