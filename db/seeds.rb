# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Crea un usuario admin
User.create(username: 'admin', password: 'admin', password_confirmation: 'admin')

# Generar registro de configuracion
Configuracion.create(nombre: 'SG')

# Crear 10 paises
for i in 1..10
	pais = Faker::Address.country
	Pais.create(nombre: pais) if Pais.where(nombre: pais).empty?
end

# Crear 15 estados para cada pais
Pais.all.each do |p|
	for i in 1..15
		estado = Faker::Address.state
		Estado.create(nombre: estado, pais_id: p.id) if Estado.where(nombre: estado).empty?
	end
end

# Crear 20 ciudades para cada estado
Estado.all.each do |e|
	for i in 1..20
		ciudad = Faker::Address.city
		Ciudad.create(nombre: ciudad, estado_id: e.id) if Ciudad.where(nombre: ciudad).empty?
	end
end

# Crear 20 proveedores
for i in 1..20
	ciudad = Ciudad.offset(rand(Ciudad.count)).first
	Proveedor.create(	nombre: Faker::Company.name,
						ruc: Faker::Number.number(9),
						direccion: Faker::Address.street_address,
						#telefono: Faker::PhoneNumber.phone_number,
						ciudad_id: ciudad.id,
						email: Faker::Internet.email)
end

# Crear 10 categorias de componentes
for i in 1..10
	categoria = Faker::Commerce.department
	ComponenteCategoria.create(nombre: categoria) if ComponenteCategoria.where(nombre: categoria).empty?
end

# Crear 10 componentes para cada categoria
ComponenteCategoria.all.each do |c|
	for i in 1..10
		componente = Faker::Commerce.product_name
		Componente.create(nombre: componente, componente_categoria_id: c.id) if Componente.where(nombre: componente).empty?
	end
end

# Crear la dos condiciones de pago
CondicionPago.create([{ nombre: 'Contado' }, { nombre: 'Credito' }])

# Crear ivas
Iva.create([{ abreviatura: '10%', porcentaje: 0.1 }, { abreviatura: '5%',porcentaje: 0.005 }])

# Crear plazos de pago
PlazoPago.create([{ nombre: '30/60/90', cuotas: '3' }, { nombre: '30/60/90/120',cuotas: '4' }])
dias = ['30','60','90','120']
PlazoPago.all.each do |p|
	p.cuotas.to_i.times do |c|
		PlazoPagoDetalle.create(plazo_pago_id: p.id, dias_vencimiento: dias[c])
	end
end
