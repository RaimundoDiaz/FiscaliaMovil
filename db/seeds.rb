# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u1 = User.create(role: 0, rut: "19838173k")
u2 = User.create(role: 1, rut: "111111")
reg_prosecution = RegionalProsecution.create(name: "fiscalia regional")
prosecution = LocalProsecution.create(name: "fiscalia 1", regional_prosecution: reg_prosecution)
procedure = Procedure.create(classification: 0, categories: ["Categoria 1", "Categoria 2"], user: u1, local_prosecution: prosecution)
person = Person.create(name: "Juan", last_name: "Perez")
pinp = PersonInProcedure.create(id: 100, procedure: procedure, person: person, role: 1)
crime = Crime.create()
crime2 = Crime.create()