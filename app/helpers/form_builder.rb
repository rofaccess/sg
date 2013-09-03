include ActionView::Helpers::FormTagHelper
include ActionView::Helpers::FormHelper
module FormBuilder

  def self.text_field(f, field, label_class = nil, field_class = nil, input_class = '')
  	html = ""
  	html << "<div class='form-group'>"
  	  html << f.label(field, class: "control-label #{label_class.nil? ? 'col-md-2' : label_class}")
  	  html << "<div class='#{field_class.nil? ? 'col-md-10' : field_class}'>"
  	  	html << f.text_field(field, class: 'form-control ' + input_class)
  	  html << "</div>"
  	html << "</div>"

  	html.html_safe
  end

  def self.collection_select(f, field, collection, value, text, prompt, label_class = nil, field_class = nil, input_class = '')
    html = ""
    html << "<div class='form-group'>"
      html << f.label(field, class: "control-label #{label_class.nil? ? 'col-md-2' : label_class}")
      html << "<div class='#{field_class.nil? ? 'col-md-10' : field_class}'>"
        html << f.collection_select(field, collection, value, text, {prompt: prompt}, {class: 'form-control ' + input_class})
      html << "</div>"
    html << "</div>"

    html.html_safe
  end
end