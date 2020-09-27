# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u1 = User.create(role: 0, rut: "19838173k")
u2 = User.create(role: 1, rut: "111111")
procedure = Procedure.create(classification: 0, categories: ["Categoria 1", "Categoria 2"], police_in_charge: u1, prosecutor_in_charge: u2)
person = Person.create(name: "Juan", last_name: "Perez")
pinp = PersonInProcedure.create(procedure: procedure, person: person, role: 1)
crime = Crime.create()