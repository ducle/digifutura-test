class NodesController < ApplicationController

  def index
    @nodes = my_nodes.roots.by_name.page(params[:page])
  end

  def show
    @file_node = my_nodes.find(params[:id])
    @nodes = @file_node.children.by_name.page(params[:page])
  end

  def new
    @parent_node = my_nodes.folders.find_by_id(params[:parent_id])
    @file_node = my_nodes.folders.new(owner_id: current_user.id, parent_id: @parent_node.try(:id))
  end

  def create
    @file_node = my_nodes.folders.new(node_param)
    @file_node.owner_id = current_user.id
    if @file_node.save
      redirect_to nodes_path
    else
      render :new
    end
  end

  def upload
    parent_node = my_nodes.folders.find_by(id: params[:parent_id])
    @file_node = my_nodes.files.new(owner_id: current_user.id)
    if params[:files] && file = params[:files].first
      @file_node.file = file
      @file_node.parent_id = parent_node.try(:id)
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
    @file_node = my_nodes.find(params[:id])
  end

  def share
    @file_node = my_nodes.find(params[:id])
    @file_node.user_ids = share_param[:user_ids]
    redirect_to node_path(@file_node.parent || @file_node)
  end


  def tagging
    @file_node = current_user.my_files.find(params[:id])
    @file_node.label_list = params[:tags]
    if @file_node.save
      render body: nil, status: 200
    else
      render body: nil, status: 400
    end
  end

  private

  def node_param
    params.require(:file_node).permit(:name, :file, :parent_id)
  end

  def share_param
    params.require(:file_node).permit(:user_ids => [])
  end

  def my_nodes
    current_user.file_nodes
  end

  # prevent nesting file node
  def ensure_nesting_folder
    if @file_node.is_file?
      redirect_to nodes_path
    end
  end
end
