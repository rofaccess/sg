include ActionView::Helpers::FormTagHelper
include ActionView::Helpers::FormHelper
module FormBuilder

  def self.text_field(f, field, label_class = nil, field_class = nil)
  	html = ""
  	html << "<div class='form-group'>"
  	  html << f.label(field, class: "control-label #{label_class.nil? ? 'col-md-2' : label_class}")
  	  html << "<div class='#{field_class.nil? ? 'col-md-10' : field_class}'>"
  	  	html << f.text_field(field, class: 'form-control')
  	  html << "</div>"
  	html << "</div>"

  	html.html_safe
  end
end