# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Crea un usuario admin
u = User.where(username: 'admin')
if u.blank?
	e = Empleado.create(nombre: 'Juan', apellido: 'Perez')
	u = User.create(username: 'admin', password: 'admin', password_confirmation: 'admin', empleado_id: e.id)
	u.add_role :admin
elsif u.first.empleado_id.nil?
	e = Empleado.create(nombre: 'Juan', apellido: 'Perez')
	u.first.empleado_id = e.id
	u.first.save
	u.first.add_role :admin
end

if Configuracion.all.blank?
	# Generar registro de configuracion
	Configuracion.create(nombre: 'SG', simbolo_moneda: 'Gs.', direccion: 'Lomas Valentinas 524 c/ Mallorquin', telefono1: '071 205698', telefono2: '071 204356', email: 'sg_dev@sistema.com')

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
	categorias = ['Placa Madre','Procesador','HDD','Monitor','Teclados y Mouses','Parlantes']
	categorias.each do |c|
		ComponenteCategoria.create(nombre: c) if ComponenteCategoria.where(nombre: c).empty?
	end

	# Crear 5 marchas de componentes
	marcas = ['Asus','Intel','Maxtor','Aoc','Verbatim','Satellite']
	marcas.each do |m|
		Marca.create(nombre: m) if Marca.where(nombre: m).empty?
	end

	# Crear Depositos para materia prima y productos terminados
	deposito1 = DepositoMateriaPrima.create(nombre: "Casa Central", descripcion: "Deposito de materias primas de la casa central")
	deposito2 = DepositoMateriaPrima.create(nombre: "Sucursal Encarnacion", descripcion: "Deposito de materias primas de la sucursal Encarnacion")
	#DepositoProductoTerminado.create(nombre: "Casa Central", disponible: false, descripcion: "Deposito de productos de la casa central")

	# Crear 5 componentes para cada categoria
	componentes = ['P8H61-M LX','Core 2 Duo','7200 RPM 1TB','16" - e1660Sw','Mouse Verbatim 000023','AS-878 2x1 SubWoofer']
	costos = [600000,550000,450000,1200000,35000,180000]
	i = 1
	componentes.each do |c|
		exist_dep1 = rand(1..20)
		exist_dep2 = rand(1..20)
		comp = Componente.create(nombre: c, costo: costos[i-1], iva_id: rand(1..2), componente_categoria_id: i, marca_id: i, existencia_total: (exist_dep1 + exist_dep2))
		# Cargar depositos
		deposito1.deposito_stocks.create(mercaderia_id: comp.id, existencia_min: 10, existencia_max: 20 , existencia: exist_dep1)
		deposito2.deposito_stocks.create(mercaderia_id: comp.id, existencia_min: 10, existencia_max: 20 , existencia: exist_dep2)
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
			PlazoPagoDetalle.create(plazo_pago_id: p.id, cant_dias: dias[c])
		end
	end

	# Crear un ejercicio contable
	datetime = DateTime.now
	EjercicioContable.create( fecha_inicio: datetime, year: datetime.year)

	# Crear cuentas contables
	CuentaContable.create( [{nombre: 'ACTIVO', nivel:'1', asentable: false, codigo: '1'},
							{nombre: 'ACTIVO CORRIENTE', nivel:'2', asentable: false, codigo: '11'},
							{nombre: 'Caja', nivel:'3', asentable: true, codigo: '111'},
							{nombre: 'Bancos', nivel:'3', asentable: true, codigo: '112'},
							{nombre: 'Mercaderias', nivel:'3', asentable: true, codigo: '113'},
							{nombre: 'Materia Prima', nivel:'4', asentable: true, codigo: '1131'},
							{nombre: 'Producto Terminado', nivel:'4', asentable: true, codigo: '1132'},
							{nombre: 'ACTIVO NO CORRIENTE', nivel:'2', asentable: false, codigo: '12'},
							{nombre: 'Deudores Fiscales', nivel:'3', asentable: false, codigo: '122'},
							{nombre: 'Iva - Credito Fiscal 10%', nivel:'4', asentable: true, codigo: '1221'},
							{nombre: 'Iva - Credito Fiscal 5%', nivel:'4', asentable: true, codigo: '1222'},
							{nombre: 'PASIVO', nivel:'1', asentable: false, codigo: '2'},
							{nombre: 'PASIVO NO CORRIENTE', nivel:'2', asentable: false, codigo: '21'},
							{nombre: 'Acreedores Comerciales', nivel:'3', asentable: false, codigo: '211'},
							{nombre: 'Proveedores', nivel:'4', asentable: true, codigo: '2111'}])

	# Crear asientos modelo
	AsientoModelo.create(concepto: 'Compra de Mercaderias segun factura credito', origen: 'Carga de Factura Compra, Condicion Credito')
	AsientoModeloDetalle.create([{valor: 'Monto sin Iva', cuenta_contable_id: 6, tipo_partida_doble: 'Debe', asiento_modelo_id: 1},
								 {valor: 'Iva 10%'      , cuenta_contable_id: 10, tipo_partida_doble: 'Debe', asiento_modelo_id: 1},
								 {valor: 'Iva 5%'       , cuenta_contable_id: 11, tipo_partida_doble: 'Debe', asiento_modelo_id: 1},
								 {valor: 'Monto Total'  , cuenta_contable_id: 15, tipo_partida_doble: 'Haber', asiento_modelo_id: 1}])
end