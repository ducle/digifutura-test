module ApplicationHelper

  def current_path?(path)
    case path
    when Regexp
      cur_path = request.fullpath
      cur_path.match(path) ? 'active' : ''
    when String
      if path =~ /#/
        paths = path.split('#')
        (controller_name == paths.first && action_name == paths.last) ? 'active' : ''
      else
        paths = controller_path.split('/')+[action_name]
        paths.include?(path) ? 'active' : ''
      end
    end
  end

  
end
