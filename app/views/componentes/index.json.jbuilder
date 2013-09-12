json.array!(@componentes) do |componente|
  json.extract! componente, :nombre, :numero_serie, :costo, :marca_id, :componente_categoria_id
  json.url componente_url(componente, format: :json)
end
