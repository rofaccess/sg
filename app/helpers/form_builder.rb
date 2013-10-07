include ActionView::Helpers::FormTagHelper
include ActionView::Helpers::FormHelper
include ActionView::Helpers::FormOptionsHelper
module FormBuilder

  def self.text_field(f, field, label_class = nil, field_class = nil, input_class = '', btn = [false, ''], input_value = nil)
  	html = ""
  	html << "<div class='form-group'>"
  	  html << f.label(field, class: "control-label #{label_class.nil? ? 'col-md-2' : label_class}")
  	  html << "<div class='#{field_class.nil? ? 'col-md-10' : field_class}'>"
  	  	if input_value.nil?
          html << f.text_field(field, class: 'form-control ' + input_class)
        else
          html << f.text_field(field, class: 'form-control ' + input_class, value: input_value)
        end
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
  # Opciones admisibles del hash option :col_class, :label_class, :input_class, :input_value, :placeholder
  def self.input_ver(f, field, option)
    html = ""
    html << "<div class='#{option.key?(:col_class) ? option[:col_class] : ''}'>"
      html << f.label(field, class: "control-label #{option.key?(:label_class) ? option[:label_class] : ''}")
      html << f.text_field(field, class: "form-control #{option.key?(:input_class) ? option[:input_class] : ''}",
                                  value: "#{option.key?(:input_value) ? option[:input_value] : ''}",
                                  placeholder: "#{option.key?(:placeholder) ? option[:placeholder] : ''}")
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
  #= FormBuilder::collection_select2(f, :condicion_pago_id, CondicionPago.all, :id, :nombre, '',nil, nil, '', nil, false)
  def self.select_ver(f, field, collection, value, text,option)
    html = ""
    html << "<div class='#{option.key?(:col_class) ? option[:col_class] : ''}'>"
      if f.nil?
        html << label_tag(field, nil, class: "control-label #{option.key?(:label_class) ? option[:label_class] : ''}")
        select_tag(field, options_from_collection_for_select(collection, value, text, option.key?(:selected) ? option[:selected] : nil),
                          {multiple: option.key?(:multiple) ? option[:multiple] : false,
                           prompt: option.key?(:prompt) ? option[:prompt] : '',
                           class: "form-control #{option.key?(:input_class) ? option[:input_class] : ''}"})
      else
        html << f.label(field, class: "control-label #{option.key?(:label_class) ? option[:label_class] : ''}")
        html << f.collection_select(field, collection, value, text,
                                    {prompt: option.key?(:prompt) ? option[:prompt] : ''},
                                    {multiple: option.key?(:multiple) ? option[:multiple] : false,
                                     class: "form-control #{option.key?(:select_class) ? option[:select_class] : ''}"})
      end
      if option.key?(:btn)
        html << "<div class='col-md-2'><a href='#{option[:btn]}' data-remote='true' class='btn btn-default btn-block'><i class='icon-plus'></i></a></div>"
      end
    html << "</div>"

    html.html_safe
  end

  def self.collection_select2(f, field, collection, value, text, prompt, label_class = nil, field_class = nil, input_class = '', selected = nil, multiple = false, btn = [false, ''])
    html = ""
    html << "<div class='form-group'>"
      if f.nil?
        html << label_tag(field, class: label_class)
      else
        html << f.label(field, class: label_class)
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