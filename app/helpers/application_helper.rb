module ApplicationHelper
  # def flash_class(level)
  #   case level
  #   when :notice then "alert alert-info"
  #   when :success then "alert alert-success"
  #   when :error then "alert alert-error"
  #   when :alert then "alert alert-error"
  #   end
  # end

  def flash_class(level)
    bootstrap_alert_class = {
      "success" => "alert-success",
      "error" => "alert-error",
      "notice" => "alert-info",
      "alert" => "alert-danger",
      "warn" =>  "alert-warning"
    }
    bootstrap_alert_class[level]
  end

  def link_to_add_fields(name = nil, f = nil, association = nil, options = nil, html_options = nil, &block)
    # If a block is provided there is no name attribute and the arguments are
    # shifted with one position to the left. This re-assigns those values.
    f, association, options, html_options = name, f, association, options if block_given?
  
    options = {} if options.nil?
    html_options = {} if html_options.nil?
  
    if options.include? :locals
      locals = options[:locals]
    else
      locals = { }
    end
  
    if options.include? :partial
      partial = options[:partial]
    else
      partial = association.to_s.singularize + '_fields'
    end
  
    # Render the form fields from a file with the association name provided
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, child_index: 'new_record') do |builder|
      render(partial, locals.merge!( f: builder))
    end
  
    # The rendered fields are sent with the link within the data-form-prepend attr
    html_options['data-form-prepend'] = raw CGI::escapeHTML( fields )
    html_options['href'] = '#'
  
    content_tag(:a, name, html_options, &block)
  end
end
