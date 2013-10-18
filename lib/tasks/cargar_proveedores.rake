namespace :cargar_proveedores do
	desc "Cargaar 10 proveedores"
	task :cargar => :environment do
		for i in 1..10
			ciudad = Ciudad.offset(rand(Ciudad.count)).first
			Proveedor.create(	nombre: Faker::Company.name,
								ruc: Faker::Number.number(9),
								direccion: Faker::Address.street_address,
								#telefono: Faker::PhoneNumber.phone_number,
								ciudad_id: ciudad.id,
								email: Faker::Internet.email)
		end
	end

end
