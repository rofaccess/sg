# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(username: 'admin', password: 'admin', password_confirmation: 'admin')

for i in 1..20
	Provider.create(	name: Faker::Company.name,
						ruc: Faker::Number.number(9),
						address: Faker::Address.street_address,
						phone: Faker::PhoneNumber.phone_number,
						email: Faker::Internet.email)
end

prov = Provider.all
prov.each do |p|
	for i in 1..10
		Product.create(name: Faker::Commerce.product_name, provider_id: p.id)
	end
end