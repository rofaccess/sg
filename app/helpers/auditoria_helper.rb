module AuditoriaHelper

  def self.format_event(event, model, id)
    object = model.constantize.with_deleted.find(id)
    mensaje = ''
    if event == 'create'
      mensaje = "Se ha generado el #{model.underscore.humanize} Nro #{object.numero}"
    elsif event == 'update'
      mensaje = "Se ha actualizado el #{model.underscore.humanize} Nro #{object.numero}"
    elsif event == 'destroy'
      mensaje = "Se ha eliminado el #{model.underscore.humanize} Nro #{object.numero}"
    end
    mensaje
  end

end