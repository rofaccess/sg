module ApplicationHelper
  def current_menu(path)
  	path.each do |p|
  		return "active" if request.url.include?(p)
  	end
  end

  def current_sidemenu(path)
  	"active" if request.url.eql?("http://localhost:3000#{path}")
  end

  def imprimir_link(url)
    link_to '<i class="icon-print icon-large"></i> Imprimir'.html_safe, url, class: 'btn btn-default pull-right', id: 'imprimir-link', target: '_blank', data: {url: url}
  end

  def imprimir_link_show(url)
    link_to '<i class="icon-print icon-large"></i> '.html_safe, url, target: '_blank'
  end
end
