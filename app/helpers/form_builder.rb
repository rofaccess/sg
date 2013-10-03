include ActionView::Helpers::FormTagHelper
include ActionView::Helpers::FormHelper
include ActionView::Helpers::FormOptionsHelper
module FormBuilder

  def self.text_field(f, field, label_class = nil, field_class = nil, input_class = '', btn = [false, ''])
  	html = ""
  	html << "<div class='form-group'>"
  	  html << f.label(field, class: "control-label #{label_class.nil? ? 'col-md-2' : label_class}")
  	  html << "<div class='#{field_class.nil? ? 'col-md-10' : field_class}'>"
  	  	html << f.text_field(field, class: 'form-control ' + input_class)
  	  html << "</div>"
      if btn[0]
        html << "<div class='col-md-2'><a href='#{btn[1]}' data-remote='true' data-url='' class='btn btn-default btn-block'><i class='icon-plus'></i></a></div>"
      end
  	html << "</div>"

  	html.html_safe
  end

  def self.text_field2(f, field, label_class = nil, field_class = nil, input_class = '', btn = [false, ''],disabled = false, input_value = '')
    html = ""
    html << "<div class='form-group'>"
      html << f.label(field)
      html << f.text_field(field, class: 'form-control ' + input_class, disabled: disabled, value: input_value)
      if btn[0]
        html << "<div class='col-md-2'><a href='#{btn[1]}' data-remote='true' data-url='' class='btn btn-default btn-block'><i class='icon-plus'></i></a></div>"
      end
    html << "</div>"

    html.html_safe
  end

  def self.file_field(f, field, label_class = nil, field_class = nil, input_class = '')
    html = ""
    html << "<div class='form-group '>"
      html << f.label(field, class: "control-label #{label_class.nil? ? 'col-md-2' : label_class}")
      html << "<div class='#{field_class.nil? ? 'col-md-10' : field_class}'>"
        html << f.file_field(field, class: 'form-control file_input ' + input_class)
      html << "</div>"
    html << "</div>"

    html.html_safe
  end

  def self.collection_select(f, field, collection, value, text, prompt, label_class = nil, field_class = nil, input_class = '', selected = nil, multiple = false, btn = [false, ''])
    html = ""
    html << "<div class='form-group'>"
      if f.nil?
        html << label_tag(field, nil, class: "control-label #{label_class.nil? ? 'col-md-2' : label_class}")
      else
        html << f.label(field, class: "control-label #{label_class.nil? ? 'col-md-2' : label_class}")
      end
      html << "<div class='#{field_class.nil? ? 'col-md-10' : field_class}'>"
        if f.nil?
          html << select_tag(field, options_from_collection_for_select(collection, value, text, selected), { multiple: multiple, prompt: prompt, class: 'form-control ' + input_class})
        else
          html << f.collection_select(field, collection, value, text, {prompt: prompt}, {multiple: multiple, class: 'form-control ' + input_class})
        end
      html << "</div>"
      if btn[0]
        html << "<div class='col-md-2'><a href='#{btn[1]}' data-remote='true' class='btn btn-default btn-block'><i class='icon-plus'></i></a></div>"
      end
    html << "</div>"

    html.html_safe
  end

  def self.collection_select2(f, field, collection, value, text, prompt, label_class = nil, field_class = nil, input_class = '', selected = nil, multiple = false, btn = [false, ''])
    html = ""
    html << "<div class='form-group'>"
      if f.nil?
        html << label_tag(field)
      else
        html << f.label(field)
      end
      if f.nil?
        html << select_tag(field, options_from_collection_for_select(collection, value, text, selected), { multiple: multiple, prompt: prompt, class: 'form-control ' + input_class})
      else
        html << f.collection_select(field, collection, value, text, {prompt: prompt}, {multiple: multiple, class: 'form-control ' + input_class})
      end
      if btn[0]
        html << "<div class='col-md-2'><a href='#{btn[1]}' data-remote='true' class='btn btn-default btn-block'><i class='icon-plus'></i></a></div>"
      end
    html << "</div>"

    html.html_safe
  end

  def self.text_field_search(f, field, placeholder)
    html = ""
    html << "<div class='input-group'>"
      html << f.text_field(field, class: 'form-control',autofocus: true, placeholder: placeholder)
      html << "<span class='input-group-btn'>"
        html << "<button class='btn btn-default' type='submit'>"
          html << "<i class='icon-search'>"
          html << "</i>"
        html << "</button>"
      html << "</span>"
    html << "</div>"

    html.html_safe
  end
end