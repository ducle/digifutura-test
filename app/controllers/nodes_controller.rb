class NodesController < ApplicationController
  layout 'landing'

  def index
    @nodes = FileNode.roots.page(params[:page])
  end

  def show
    @file_node = FileNode.find(params[:id])
    @nodes = @file_node.children.page(params[:page])
  end

  def new
    @file_node = FileNode.new(node_type: FileNode::NODE_TYPES[:folder], parent_id: params[:parent_id])
  end

  def create
    @file_node = FileNode.new(node_param)
    @file_node.owner_id = current_user.id
    if @file_node.save
      redirect_to :back
    else
      render :new
    end
  end

  def upload
    @file_node = FileNode.new(node_type: FileNode::NODE_TYPES[:file])
    @file_node.owner_id = current_user.id
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


  private

  def node_param
    params.require(:file_node).permit(:name, :file, :parent_id)
  end
end
