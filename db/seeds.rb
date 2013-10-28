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
Configuracion.create(nombre: 'SG', simbolo_moneda: '')

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

# Crear 5 proveedores
for i in 1..5
	ciudad = Ciudad.offset(rand(Ciudad.count)).first
	Proveedor.create(	nombre: Faker::Company.name,
						ruc: Faker::Number.number(9),
						direccion: Faker::Address.street_address,
						ciudad_id: ciudad.id,
						email: Faker::Internet.email)
end

# Agregar 1 telefono a cada proveedor
Proveedor.all.each do |p|
	Telefono.create(numero: Faker::PhoneNumber.phone_number, persona_id: p.id)
end

# Crear ivas
Iva.create([{ valor: '10'}, { valor: '5'}])

# Crear 5 categorias de componentes
categorias = ['Placa Madre','Disco Duro','Procesador','Memoria','Monitor','Teclados y Mouses']
categorias.each do |c|
	ComponenteCategoria.create(nombre: c) if ComponenteCategoria.where(nombre: c).empty?
end

# Crear 5 marchas de componentes
marcas = ['Asus','Intel','Amd','Lenovo','Aoc','Toshiba']
marcas.each do |m|
	Marca.create(nombre: m) if Marca.where(nombre: m).empty?
end

# Crear 5 componentes para cada categoria
componentes = ['ATX-2324','MSProLInk','PCChips','LM 256 Mhz','SL-5343L','Tok-14']
i = 1
componentes.each do |c|
		costo = rand(2000..10000)
		Componente.create(nombre: c, costo: costo, iva_id: rand(1..2), componente_categoria_id: i, marca_id: i)
		i += 1
end

# Agregar todas las categorias a 5 proveedores
Proveedor.limit(5).each do |p|
	ComponenteCategoria.all.each do |c|
		p.componente_categorias << c
	end
end


# Crear la dos condiciones de pago
CondicionPago.create([{ nombre: 'Contado' }, { nombre: 'Credito' }])

# Crear plazos de pago
PlazoPago.create([{ nombre: '30/60/90', cuotas: '3' }, { nombre: '30/60/90/120',cuotas: '4' }])
dias = ['30','60','90','120']
PlazoPago.all.each do |p|
	p.cuotas.to_i.times do |c|
		PlazoPagoDetalle.create(plazo_pago_id: p.id, dias_vencimiento: dias[c])
	end
end
