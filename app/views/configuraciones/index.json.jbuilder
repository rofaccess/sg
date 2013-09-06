json.array!(@configuraciones) do |configuracion|
  json.extract! configuracion, :nombre, :direccion, :imagen
  json.url configuracion_url(configuracion, format: :json)
end
