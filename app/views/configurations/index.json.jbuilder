json.array!(@configurations) do |configuration|
  json.extract! configuration, :company_name, :image
  json.url configuration_url(configuration, format: :json)
end
