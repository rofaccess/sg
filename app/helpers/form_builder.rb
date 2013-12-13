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

  def self.text_field_h(f, field, option)
    html = ""
    html << "<div class='form-group'>"
      html << f.label(field, "#{option.key?(:label_text) ? option[:label_text] : ''}", class: "control-label #{option.key?(:label_class) ? option[:label_class] : 'col-md-2'}")
      html << "<div class='#{option.key?(:field_class) ? option[:field_class] : 'col-md-10'}'>"
        html << f.text_field(field, class: "form-control #{option.key?(:input_class) ? option[:input_class] : ''}", placeholder: "#{option.key?(:placeholder) ? option[:placeholder] : ''}", disabled: option.key?(:disabled) ? option[:disabled] : false, readonly: option.key?(:readonly) ? option[:readonly] : false, maxLength: "#{option.key?(:max_length) ? option[:max_length] : '150'}", autofocus: option.key?(:autofocus) ? option[:autofocus] : false)
      html << "</div>"
      if option.key?(:btn)
        html << "<div class='col-md-2'><a href='#{option[:btn]}' data-remote='true' data-url='' class='btn btn-default btn-block'><i class='icon-plus'></i></a></div>"
      end
      if option.key?(:btn_del_class)
        html << "<div class='col-md-2'><a href='#' onclick='#{option[:onclick]}' class='btn btn-default btn-block #{option[:btn_del_class]}'><i class='icon-minus'></i></a></div>"
      end
    html << "</div>"

    html.html_safe
  end

  def self.password_field(f, field, option)
    html = ""
    html << "<div class='form-group'>"
      html << f.label(field, "#{option.key?(:label_text) ? option[:label_text] : ''}", class: "control-label #{option.key?(:label_class) ? option[:label_class] : 'col-md-2'}")
      html << "<div class='#{option.key?(:field_class) ? option[:field_class] : 'col-md-10'}'>"
        html << f.password_field(field, class: "form-control #{option.key?(:input_class) ? option[:input_class] : ''}", placeholder: "#{option.key?(:placeholder) ? option[:placeholder] : ''}", disabled: option.key?(:disabled) ? option[:disabled] : false, readonly: option.key?(:readonly) ? option[:readonly] : false, maxLength: "#{option.key?(:max_length) ? option[:max_length] : '150'}", minLength: "#{option.key?(:min_length) ? option[:min_length] : '3'}")
      html << "</div>"
    html << "</div>"

    html.html_safe
  end

  # Opciones admisibles del hash option :col_class, :label_class, :input_class, :input_value, :placeholder, :label_text, :disabled, :readonly
  # Para el hash option no es necesario la llave cuando se usa el metodo
  def self.text_field_v(f, field, option)
    html = ""
      html << "<div class='form-group #{option.key?(:col_class) ? option[:col_class] : ''}'>"
        html << f.label(field,"#{option.key?(:label_text) ? option[:label_text] : ''}", class: "control-label #{option.key?(:label_class) ? option[:label_class] : ''}")
        if option.key?(:input_value)
          html << f.text_field(field, class: "form-control #{option.key?(:input_class) ? option[:input_class] : ''}",value: "#{option.key?(:input_value) ? option[:input_value] : ''}", placeholder: "#{option.key?(:placeholder) ? option[:placeholder] : ''}", disabled: option.key?(:disabled) ? option[:disabled] : false, readonly: option.key?(:readonly) ? option[:readonly] : false, maxLength: "#{option.key?(:max_length) ? option[:max_length] : '150'}", autofocus: option.key?(:autofocus) ? option[:autofocus] : false)
        else
          html << f.text_field(field, class: "form-control #{option.key?(:input_class) ? option[:input_class] : ''}",placeholder: "#{option.key?(:placeholder) ? option[:placeholder] : ''}", disabled: option.key?(:disabled) ? option[:disabled] : false, readonly: option.key?(:readonly) ? option[:readonly] : false, maxLength: "#{option.key?(:max_length) ? option[:max_length] : '150'}", autofocus: option.key?(:autofocus) ? option[:autofocus] : false)
        end
        if option.key?(:btn)
          html << "<div class='col-md-2'><a href='#{option[:btn]}' data-remote='true' data-url='' class='btn btn-default btn-block'><i class='icon-plus'></i></a></div>"
        end
      html << "</div>"
    html.html_safe
  end

  # Opciones admisibles del hash option :col_class, :label_class, :input_class, :input_value, :placeholder, :label_text, :disabled, :readonly
  # Para el hash option no es necesario la llave cuando se usa el metodo
  def self.text_area_v(f, field, option)
    html = ""
      html << "<div class='form-group #{option.key?(:col_class) ? option[:col_class] : ''}'>"
        html << f.label(field,"#{option.key?(:label_text) ? option[:label_text] : ''}", class: "control-label #{option.key?(:label_class) ? option[:label_class] : ''}")
        html << f.text_area(field, cols: "#{option.key?(:cols) ? option[:cols] : '10'}", rows: "#{option.key?(:rows) ? option[:rows] : '10'}",class: "form-control #{option.key?(:input_class) ? option[:input_class] : ''}",placeholder: "#{option.key?(:placeholder) ? option[:placeholder] : ''}", disabled: option.key?(:disabled) ? option[:disabled] : false, readonly: option.key?(:readonly) ? option[:readonly] : false, maxLength: "#{option.key?(:max_length) ? option[:max_length] : '150'}", autofocus: option.key?(:autofocus) ? option[:autofocus] : false)
      html << "</div>"
    html.html_safe
  end

  def self.text_area_h(f, field, option)
    html = ""
    html << "<div class='form-group'>"
      html << f.label(field, "#{option.key?(:label_text) ? option[:label_text] : ''}", class: "control-label #{option.key?(:label_class) ? option[:label_class] : 'col-md-2'}")
      html << "<div class='#{option.key?(:field_class) ? option[:field_class] : 'col-md-10'}'>"
        html << f.text_area(field, cols: "#{option.key?(:cols) ? option[:cols] : '10'}", rows: "#{option.key?(:rows) ? option[:rows] : '10'}",class: "form-control #{option.key?(:input_class) ? option[:input_class] : ''}",placeholder: "#{option.key?(:placeholder) ? option[:placeholder] : ''}", disabled: option.key?(:disabled) ? option[:disabled] : false, readonly: option.key?(:readonly) ? option[:readonly] : false, maxLength: "#{option.key?(:max_length) ? option[:max_length] : '150'}", autofocus: option.key?(:autofocus) ? option[:autofocus] : false)
      html << "</div>"
    html << "</div>"

    html.html_safe
  end

  # Opciones admisibles del hash option :col_class, :label_class, :input_class, :input_value, :placeholder, :label_text, :disabled, :readonly
  # Para el hash option no es necesario la llave cuando se usa el metodo
  def self.rango_fechas(f, field_desde, field_hasta, options)
    html = ""
      html << "<div class='form-group rango-fechas #{options.key?(:col_class) ? options[:col_class] : ''}'>"
        html << f.label(field_desde,"#{options.key?(:label_text) ? options[:label_text] : ''}", class: "control-label #{options.key?(:label_class) ? options[:label_class] : ''}")
        html << "<div class='row'>"
          html << "<div class='col-md-6'>"
            html << f.text_field(field_desde, class: "form-control datepicker has-clear",value: "#{options.key?(:input_value) ? options[:input_value] : ''}", placeholder: "Desde", disabled: options.key?(:disabled) ? options[:disabled] : false, readonly: options.key?(:readonly) ? options[:readonly] : false, maxLength: "#{options.key?(:max_length) ? options[:max_length] : Domain::FECHA}")
          html << "</div>"
          html << "<div class='col-md-6'>"
            html << f.text_field(field_hasta, class: "form-control datepicker has-clear",value: "#{options.key?(:input_value) ? options[:input_value] : ''}", placeholder: "Hasta", disabled: options.key?(:disabled) ? options[:disabled] : false, readonly: options.key?(:readonly) ? options[:readonly] : false, maxLength: "#{options.key?(:max_length) ? options[:max_length] : Domain::FECHA}")
          html << "</div>"
        html << "</div>"
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

  # Opciones admisibles del hash option :col_class, :label_class, :input_class, :input_value, :placeholder, :label_text, :disabled, :readonly
  # Para el hash option no es necesario la llave cuando se usa el metodo
  def self.collection_select_v(f, field, collection, value, text,option)
    html = ""
    html << "<div class='form-group #{option.key?(:col_class) ? option[:col_class] : ''}'>"
      if f.nil?
        html << label_tag(field, option.key?(:label_text) ? option[:label_text] : nil,
                                 class: "control-label #{option.key?(:label_class) ? option[:label_class] : ''}")

        html << select_tag(field, options_from_collection_for_select(collection, value, text, option.key?(:selected) ? option[:selected] : nil),
                          {multiple: option.key?(:multiple) ? option[:multiple] : false,
                           prompt: option.key?(:prompt) ? option[:prompt] : '',
                           class: "form-control #{option.key?(:select_class) ? option[:select_class] : ''}",
                           disabled: option.key?(:disabled) ? option[:disabled] : false,
                           readonly: option.key?(:readonly) ? option[:readonly] : false,
                           autofocus: option.key?(:autofocus) ? option[:autofocus] : false})
      else
        html << f.label(field, "#{option.key?(:label_text) ? option[:label_text] : ''}",
                               class: "control-label #{option.key?(:label_class) ? option[:label_class] : ''}")

        html << f.collection_select(field, collection, value, text,
                                    {prompt: option.key?(:prompt) ? option[:prompt] : ''},
                                    {multiple: option.key?(:multiple) ? option[:multiple] : false,
                                      class: "form-control #{option.key?(:select_class) ? option[:select_class] : ''}",
                                      disabled: option.key?(:disabled) ? option[:disabled] : false,
                                      readonly: option.key?(:readonly) ? option[:readonly] : false,
                                      autofocus: option.key?(:autofocus) ? option[:autofocus] : false})
      end
      if option.key?(:btn)
        html << "<div class='col-md-2'><a href='#{option[:btn]}' data-remote='true' class='btn btn-default btn-block'><i class='icon-plus'></i></a></div>"
      end
    html << "</div>"

    html.html_safe
  end

  # Opciones admisibles del hash option :col_class, :label_class, :input_class, :input_value, :placeholder, :label_text, :disabled, :readonly
  # Para el hash option no es necesario la llave cuando se usa el metodo
  def self.collection_select_h(f, field, collection, value, text,option)
    html = ""
    html << "<div class='form-group #{option.key?(:col_class) ? option[:col_class] : ''}'>"
      if f.nil?
        html << label_tag(field, option.key?(:label_text) ? option[:label_text] : nil,
                                 class: "control-label #{option.key?(:label_class) ? option[:label_class] : ''}")
        html << "<div class='#{option.key?(:field_class) ? option[:field_class] : 'col-md-10'}'>"
          html << select_tag(field, options_from_collection_for_select(collection, value, text, option.key?(:selected) ? option[:selected] : nil),
                          {multiple: option.key?(:multiple) ? option[:multiple] : false,
                           prompt: option.key?(:prompt) ? option[:prompt] : '',
                           class: "form-control #{option.key?(:select_class) ? option[:select_class] : ''}",
                           disabled: option.key?(:disabled) ? option[:disabled] : false,
                           readonly: option.key?(:readonly) ? option[:readonly] : false,
                           autofocus: option.key?(:autofocus) ? option[:autofocus] : false})
        html << "</div>"
      else
        html << f.label(field, "#{option.key?(:label_text) ? option[:label_text] : ''}",
                               class: "control-label #{option.key?(:label_class) ? option[:label_class] : ''}")
        html << "<div class='#{option.key?(:field_class) ? option[:field_class] : 'col-md-10'}'>"
          html << f.collection_select(field, collection, value, text,
                                    {prompt: option.key?(:prompt) ? option[:prompt] : ''},
                                    {multiple: option.key?(:multiple) ? option[:multiple] : false,
                                      class: "form-control #{option.key?(:select_class) ? option[:select_class] : ''}",
                                      disabled: option.key?(:disabled) ? option[:disabled] : false,
                                      readonly: option.key?(:readonly) ? option[:readonly] : false,
                                      autofocus: option.key?(:autofocus) ? option[:autofocus] : false})
        html << "</div>"
      end
      if option.key?(:btn)
        html << "<div class='col-md-2'><a href='#{option[:btn]}' data-remote='true' class='btn btn-default btn-block'><i class='icon-plus'></i></a></div>"
      end
    html << "</div>"

    html.html_safe
  end

  # Opciones admisibles del hash option :col_class, :label_class, :input_class, :input_value, :placeholder, :label_text, :disabled, :readonly
  # Para el hash option no es necesario la llave cuando se usa el metodo
  def self.select(f, field, collection, option)
    html = ""
    html << "<div class='form-group #{option.key?(:col_class) ? option[:col_class] : ''}'>"
      if f.nil?
        html << label_tag(field, option.key?(:label_text) ? option[:label_text] : nil,
                                 class: "control-label #{option.key?(:label_class) ? option[:label_class] : ''}")

        html << select_tag(field, options_for_select(collection, option.key?(:selected) ? option[:selected] : nil),
                          {multiple: option.key?(:multiple) ? option[:multiple] : false,
                           prompt: option.key?(:prompt) ? option[:prompt] : '',
                           class: "form-control #{option.key?(:input_class) ? option[:input_class] : ''}",
                           disabled: option.key?(:disabled) ? option[:disabled] : false,
                           readonly: option.key?(:readonly) ? option[:readonly] : false,
                           autofocus: option.key?(:autofocus) ? option[:autofocus] : false})
      else
        html << f.label(field, "#{option.key?(:label_text) ? option[:label_text] : ''}",
                               class: "control-label #{option.key?(:label_class) ? option[:label_class] : ''}")

        html << f.select(field, collection,
                                    {prompt: option.key?(:prompt) ? option[:prompt] : ''},
                                    {multiple: option.key?(:multiple) ? option[:multiple] : false,
                                      class: "form-control #{option.key?(:select_class) ? option[:select_class] : ''}",
                                      disabled: option.key?(:disabled) ? option[:disabled] : false,
                                      readonly: option.key?(:readonly) ? option[:readonly] : false,
                                      autofocus: option.key?(:autofocus) ? option[:autofocus] : false})
      end
      if option.key?(:btn)
        html << "<div class='col-md-2'><a href='#{option[:btn]}' data-remote='true' class='btn btn-default btn-block'><i class='icon-plus'></i></a></div>"
      end
    html << "</div>"

    html.html_safe
  end

  # Opciones admisibles del hash option :col_class, :label_class, :input_class, :input_value, :placeholder, :label_text, :disabled, :readonly
  # Para el hash option no es necesario la llave cuando se usa el metodo
  def self.select_h(f, field, collection, option)
    html = ""
    html << "<div class='form-group #{option.key?(:col_class) ? option[:col_class] : ''}'>"
    if f.nil?
      html << label_tag(field, option.key?(:label_text) ? option[:label_text] : nil,
                                 class: "control-label #{option.key?(:label_class) ? option[:label_class] : ''}")
      html << "<div class='#{option.key?(:field_class) ? option[:field_class] : 'col-md-10'}'>"
        html << select_tag(field, options_for_select(collection, option.key?(:selected) ? option[:selected] : nil),
                           {multiple: option.key?(:multiple) ? option[:multiple] : false,
                             prompt: option.key?(:prompt) ? option[:prompt] : '',
                             class: "form-control #{option.key?(:input_class) ? option[:input_class] : ''}",
                             disabled: option.key?(:disabled) ? option[:disabled] : false,
                             readonly: option.key?(:readonly) ? option[:readonly] : false,
                             autofocus: option.key?(:autofocus) ? option[:autofocus] : false})
      html << "</div>"
    else
      html << f.label(field, "#{option.key?(:label_text) ? option[:label_text] : ''}",
                               class: "control-label #{option.key?(:label_class) ? option[:label_class] : ''}")
      html << "<div class='#{option.key?(:field_class) ? option[:field_class] : 'col-md-10'}'>"
        html << f.select(field, collection,
                                    {prompt: option.key?(:prompt) ? option[:prompt] : ''},
                                    {multiple: option.key?(:multiple) ? option[:multiple] : false,
                                      class: "form-control #{option.key?(:select_class) ? option[:select_class] : ''}",
                                      disabled: option.key?(:disabled) ? option[:disabled] : false,
                                      readonly: option.key?(:readonly) ? option[:readonly] : false,
                                      autofocus: option.key?(:autofocus) ? option[:autofocus] : false})
      html << "</div>"
    end
    if option.key?(:btn)
      html << "<div class='col-md-2'><a href='#{option[:btn]}' data-remote='true' class='btn btn-default btn-block'><i class='icon-plus'></i></a></div>"
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