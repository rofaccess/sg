json.array!(@componentes_categorias) do |componente_categoria|
  json.extract! componente_categoria, :nombre
  json.url componente_categoria_url(componente_categoria, format: :json)
end
