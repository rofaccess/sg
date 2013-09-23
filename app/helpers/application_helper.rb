module ApplicationHelper
  def current_menu(path)
  	path.each do |p|
  		return "active" if request.url.include?(p)
  	end
  end

  def current_sidemenu(path)
  	"active" if request.url.eql?("http://localhost:3000#{path}")
  end
end
