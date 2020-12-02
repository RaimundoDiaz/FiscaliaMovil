require 'roo'
excel_file = Roo::Spreadsheet.open('./datos.xlsx')
#Crimes
#drop(1) is for skipping the first row
excel_file.sheet(0).drop(1).each do |row|
  id = row[0]
  name = row[1].squeeze
  Crime.create!(id:id, name: name)
end
##################################
#Prefecture
excel_file.sheet(5).drop(1).each do |row|
  id = row[0]
  name = row[1].squeeze
  region = row[2]
  Prefecture.create!(id:id, name: name, region: region)
end
##########################
#RegionalProsecutions
excel_file.sheet(2).drop(1).each do |row|
  id = row[0]
  name = row[1].squeeze
  region = row[2]
  RegionalProsecution.create!(id:id, name: name, region: region)
end
##########################
#LocalProsecutions
excel_file.sheet(1).drop(1).each do |row|
  id = row[0]
  name = row[1].squeeze
  regional_prosecution_id = row[2]
  LocalProsecution.create!(id:id, name: name, regional_prosecution_id: regional_prosecution_id)
end
##################################
#Police Stations
excel_file.sheet(4).drop(1).each do |row|
  id = row[0]
  name = row[1].squeeze
  prefecture = row[2]
  police_type = row[3]
  PoliceStation.create!(id:id, name: name, prefecture_id: prefecture, police_type: police_type)
end
##################################
#Police Units
excel_file.sheet(3).drop(1).each do |row|
  id = row[0]
  name = row[1].squeeze
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
policemen_db_size = 40
while i < policemen_db_size  do
  name = FFaker::Name.name
  rut = Faker::ChileRut.unique.full_rut
  badge = Faker::Number.unique.number(digits: 7)
  phone_number = "+569" + Faker::Number.unique.number(digits: 8).to_s
  PoliceMan.create(name: name, rut: rut, badge: badge, phone_number: phone_number)
  i +=1
end
######################################
# Create local prosecutors
@prosecutions = LocalProsecution.all

for pros in @prosecutions
  name = FFaker::Name.name
  rut = Faker::ChileRut.unique.full_rut
  prosecution = pros
  Prosecutor.create(name: name, rut: rut, local_prosecution: prosecution)

  name = FFaker::Name.name
  rut = Faker::ChileRut.unique.full_rut
  prosecution = pros
  Prosecutor.create(name: name, rut: rut, local_prosecution: prosecution)
end

######################################
# Create persons (more alive than dead)
i=0
while i < 30  do
  name = FFaker::Name.name
  last_name = FFaker::Name.last_name
  rut = Faker::ChileRut.unique.full_rut
  bool = Faker::Boolean.boolean(true_ratio: 0.3)
  birthday = Faker::Date.birthday(min_age: 18, max_age: 80)
  Person.create(name: name, last_name: last_name, rut: rut, deceased: bool, birthday: birthday)
  i +=1
end

######################################
# CUENTAS PARA USAR RAPIDAMENTE
# admin@admin.com = super admin
# fiscalia1607@admin.com = admin de fiscalia local
# up10101@admin.com = admin de unidad policial
# up10101@up.com = cuenta de unidad policial
# rponce@fiscalia.com = cuenta de fiscal


User.create(email: "admin@admin.com", password: "123456789", admin: true)
Prosecutor.create(name: "Rodrigo Ponce", rut: "19638846-k", local_prosecution_id: 1607)


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