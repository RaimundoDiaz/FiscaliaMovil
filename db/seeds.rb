require 'roo'
excel_file = Roo::Spreadsheet.open('./datos.xlsx')
#Crimes
#drop(1) is for skipping the first row
excel_file.sheet(0).drop(1).each do |row|
  id = row[0]
  name = row[1].strip
  Crime.create!(id:id, name: name)
end
##################################
#Prefecture
excel_file.sheet(5).drop(1).each do |row|
  id = row[0]
  name = row[1].strip
  region = row[2]
  Prefecture.create!(id:id, name: name, region: region)
end
##########################
#RegionalProsecutions
excel_file.sheet(2).drop(1).each do |row|
  id = row[0]
  name = row[1].strip
  region = row[2]
  RegionalProsecution.create!(id:id, name: name, region: region)
end
##########################
#LocalProsecutions
excel_file.sheet(1).drop(1).each do |row|
  id = row[0]
  name = row[1].strip
  regional_prosecution_id = row[2]
  LocalProsecution.create!(id:id, name: name, regional_prosecution_id: regional_prosecution_id)
end
##################################
#Police Stations
excel_file.sheet(4).drop(1).each do |row|
  id = row[0]
  name = row[1].strip
  prefecture = row[2]
  police_type = row[3]
  PoliceStation.create!(id:id, name: name, prefecture_id: prefecture, police_type: police_type)
end
##################################
#Police Units
excel_file.sheet(3).drop(1).each do |row|
  id = row[0]
  name = row[1].strip
  police_station = row[2]
  begin
    PoliceUnit.create!(id:id, name: name, police_station_id: police_station)
  rescue
  ensure
  end
end
######################################
# Create police men
i=0
policemen_db_size = 80
while i < policemen_db_size  do
  name = FFaker::Name.name
  rut = Faker::ChileRut.unique.full_rut
  badge = Faker::Number.unique.number(digits: 7)
  PoliceMan.create(name: name, rut: rut, badge: badge)
  i +=1
end
######################################
# Create local prosecutors
i=0
prosecutor_db_size = 80
while i < prosecutor_db_size  do
  name = FFaker::Name.name
  rut = Faker::ChileRut.unique.full_rut
  prosecution = LocalProsecution.order('RANDOM()').first
  Prosecutor.create(name: name, rut: rut, local_prosecution: prosecution)
  i +=1
end
######################################
# Create persons (more alive than dead)
i=0
while i < 50  do
  name = FFaker::Name.name
  last_name = FFaker::Name.last_name
  rut = Faker::ChileRut.unique.full_rut
  bool = Faker::Boolean.boolean(true_ratio: 0.3)
  birthday = Faker::Date.birthday(min_age: 18, max_age: 80)
  Person.create(name: name, last_name: last_name, rut: rut, deceased: bool, birthday: birthday)
  i +=1
end

######################################
admin = User.create(email: "admin@gmail.com", password: "123456789", admin: true)
u1 = User.create(police_unit_id: 10101, email: "unidadpolicia1@gmail.com", password: "123456789")
u2 = User.create(local_prosecution_id: 1607, email: "fiscal1@gmail.com", password: "123456789")
u3 = User.create(police_unit_id: 10102, email: "unidadpolicia2@gmail.com", password: "123456789")
police = PoliceMan.find(1)
prosecutor = Prosecutor.create(name: "Rodrigo Ponce", rut: "19638846-k", local_prosecution_id: 1607)
procedure1 = Procedure.create(story: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?", state: 0, address: "Monseñor Álvaro del Portillo 123456", sector: "Las Condes", region: "Metropolitana", date_of_arrest: Date.today ,classification: 0, police_unit_in_charge_id: 10101, police_in_charge: police, local_prosecution_in_charge_id: 1607, prosecutor_in_charge: prosecutor, involves_deceased: false)
procedure2 = Procedure.create(story: "Robo con intimidacion", state: 0, address: "Alicura 4339", sector: "Lo Barnechea", region: "Metropolitana", date_of_arrest: Date.yesterday, classification: 1, police_unit_in_charge_id: 10101, police_in_charge: police, local_prosecution_in_charge_id: 1607, prosecutor_in_charge: prosecutor, involves_deceased: false)
person = Person.create(name: "Juan", last_name: "Perez", rut: "19838173-k", deceased: false, birthday: Date.new(2000))
imputado = Person.create(name: "Martin", last_name: "Moreno", rut: "19838173-k", deceased: true, birthday: Date.new(1997))
imputado2 = Person.create(name: "Gian", last_name: "Traverso", rut: "19687033-4", deceased: false, birthday: Date.new(1997))
PersonInProcedure.create(procedure: procedure1, person: person, role: 1, witness_declaration: "Un niño flotó sobre mí y voló un auto con su rasho laser")
PersonInProcedure.create(procedure: procedure1, person: imputado, role: 0, state: 0)
PersonInProcedure.create(procedure: procedure1, person: imputado2, role: 0, state: 0)
CrimeInAccused.create(person: imputado, crime_id: 101, procedure: procedure1, preponderant: true)
CrimeInAccused.create(person: imputado, crime_id: 310, procedure: procedure1, preponderant: false)
msg1 = Message.create(user: u1, procedure: procedure1, content: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.")
msg2 = Message.create(user: u1, procedure: procedure1, content: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.")
msg3 = Message.create(user: u2, procedure: procedure1, content: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.")


tag1 = Tag.create(name: "Estallido Social")
tag2 = Tag.create(name: "DS18")
tag3 = Tag.create(name: "VIF")
tag4 = Tag.create(name: "Vehicular")
tag5 = Tag.create(name: "Robo")
tag6 = Tag.create(name: "Disturbios")
tag7 = Tag.create(name: "Narcotráfico")
tag8 = Tag.create(name: "Persecusión")
tag9 = Tag.create(name: "Asalto")
tag10 = Tag.create(name: "Heridos")
Tagging.create(tag: tag1, procedure: procedure1)
Tagging.create(tag: tag3, procedure: procedure1)
Tagging.create(tag: tag2, procedure: procedure1)
Tagging.create(tag: tag5, procedure: procedure2)
Tagging.create(tag: tag6, procedure: procedure1)
Tagging.create(tag: tag9, procedure: procedure2)


procedure3 = Procedure.create(story: "Asalto a mano armada", state: 0, address: "Las Flores 12152", sector: "Las Condes", region: "Metropolitana", date_of_arrest: Date.yesterday, classification: 1, police_unit_in_charge_id: 10101, police_in_charge: police, local_prosecution_in_charge_id: 1607, prosecutor_in_charge: prosecutor, involves_deceased: true)
Tagging.create(tag: tag10, procedure: procedure3)
Tagging.create(tag: tag9, procedure: procedure3)

#Notification.create(user_id: 2, notification_type: 0, reference_id: 1, seen: false)