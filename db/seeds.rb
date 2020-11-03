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

u1 = User.create(police_unit_id: 10101, email: "andresvialcorrea99@gmail.com", password: "123456789")
u2 = User.create(local_prosecution_id: 102, email: "andresvialcorrea97@gmail.com", password: "123456789")
police = PoliceMan.create(name: "Jonathan Castro", rut: "19638546-k", badge:1524352, police_unit_id: 10101)
prosecutor = Prosecutor.create(name: "Rodrigo Ponce", rut: "19638846-k", local_prosecution_id: 102)
procedure1 = Procedure.create(story: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?", state: 1, address: "Alicura 4339", sector: "Lo Barnechea", region: "Metropolitana", classification: 0, police_unit_in_charge_id: 10101, police_in_charge: police, local_prosecution_in_charge_id: 103, prosecutor_in_charge: prosecutor, involves_deceased: false)
procedure2 = Procedure.create(story: "HOLAAAA Sed", state: 1, address: "Alicura 4339", sector: "Lo Barnechea", region: "Metropolitana", classification: 1, police_unit_in_charge_id: 10101, police_in_charge: police, local_prosecution_in_charge_id: 103, prosecutor_in_charge: prosecutor, involves_deceased: false)
person = Person.create(name: "Juan", last_name: "Perez", rut: "19838173-k", deceased: false, birthday: Date.new(2000))
imputado = Person.create(name: "Martin", last_name: "Moreno", rut: "19838173-k", deceased: true, birthday: Date.new(1997))
imputado2 = Person.create(name: "Gian", last_name: "Traverso", rut: "19687033-4", deceased: false, birthday: Date.new(1997))
PersonInProcedure.create(procedure: procedure1, person: person, role: 1, witness_declaration: "Un niño flotó sobre mí y voló un auto con su rasho laser")
PersonInProcedure.create(procedure: procedure1, person: imputado, role: 0)
PersonInProcedure.create(procedure: procedure1, person: imputado2, role: 0)
CrimeInAccused.create(person: imputado, crime_id: 101, procedure: procedure1, preponderant: true)
CrimeInAccused.create(person: imputado, crime_id: 310, procedure: procedure1, preponderant: false)
msg1 = Message.create(user: u1, procedure: procedure1, content: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.")
msg2 = Message.create(user: u1, procedure: procedure1, content: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.")
msg3 = Message.create(user: u2, procedure: procedure1, content: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.")
tag1 = Tag.create(name: "Estallido Social")
tag2 = Tag.create(name: "tag2")
tag3 = Tag.create(name: "tag3")
Tagging.create(tag: tag1, procedure: procedure1)
Tagging.create(tag: tag3, procedure: procedure1)
Tagging.create(tag: tag2, procedure: procedure1)
Tagging.create(tag: tag2, procedure: procedure2)
Tagging.create(tag: tag3, procedure: procedure1)
Tagging.create(tag: tag3, procedure: procedure2)

