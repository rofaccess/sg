module ApplicationHelper
  def current_menu(path)
  	"active" if request.url.include?(path)
  end
end
