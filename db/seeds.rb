# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

p = Prefecture.create(name: "prefectura")
ps = PoliceStation.create(prefecture: p)
pu = PoliceUnit.create(police_station: ps)
reg_prosecution = RegionalProsecution.create(name: "fiscalia regional")
prosecution = LocalProsecution.create(name: "fiscalia 1", regional_prosecution: reg_prosecution)
u1 = User.create(email: "fiscal1@atenas.cl", local_prosecution: prosecution)
police = PoliceMan.create(name: "Gian", police_unit_id: pu.id)
prosecutor = Prosecutor.create(name: "Martin", local_prosecutions_id: prosecution.id)

#u2 = User.create(role: 1, rut: "111111")
procedure = Procedure.create(classification: 0, marks: '{"Categoria 1", "Categoria 2"}', state: 1, police_in_charge_id: police.id, police_unit_in_charge_id: police.police_unit_id, prosecutor_in_charge_id: prosecutor.id, local_prosecution_in_charge_id: prosecutor.local_prosecutions_id)

imputado = Person.create(name: "Juan", last_name: "Perez", rut: "19838173-k")
PersonInProcedure.create(procedure: procedure, person: imputado, role: 0)
crime = Crime.create()
crime2 = Crime.create()
CrimeInAccused.create(crime: crime, person: imputado, procedure: procedure, preponderant: true)
CrimeInAccused.create(crime: crime2, person: imputado, procedure: procedure, preponderant: false)

testigo = Person.create(name: "Gian", last_name: "Vial", rut: "11111-k")
testigo2 = Person.create(name: "Martin", last_name: "Vial", rut: "111212111-k")
PersonInProcedure.create(procedure: procedure, person: testigo, role: 1)
PersonInProcedure.create(procedure: procedure, person: testigo2, role: 1)

victima = Person.create(name: "Martin", last_name: "Moreno", rut: "1115511-k")
PersonInProcedure.create(procedure: procedure, person: victima, role: 2)
