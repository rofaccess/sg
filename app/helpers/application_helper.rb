module ApplicationHelper
  def current_menu(path)
  	path.each do |p|
  		return "active" if request.url.include?(p)
  	end
  end

  def current_sidemenu(path)
  	"active" if request.url.eql?("http://localhost:3000#{path}")
  end

 #  def link_to_add_fields(name, f, association)
 #    new_object = f.object.class.reflect_on_association(association).klass.new
 #    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
	#   render(association.to_s.singularize + "_fields", :f => builder)
	# end
	# link_to_function(name, h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"))
 #  end
end
