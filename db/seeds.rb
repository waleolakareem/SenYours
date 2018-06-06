require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User to Test Database:
  # User.create!({first_name: 'Blaine', last_name: 'Anderson', email: 'blaine@gmail.com', phone_number:'9485949383', password:'password', password_confirmation:'password', terms_of_service:'yes' ,privacy_policy:'yes', identification:'Companion', description: 'I will be willing to travel to take care of individuals, take them on a walk and also for shopping', address: Faker::Address.street_address, city:'Oakland', state:'California', fee: '20', dob: '08/12/1986',availability: true})
  # User.create!({first_name: 'Kelli', last_name: 'Potter', email: 'kelli@gmail.com', phone_number:'9485949382', password:'password', password_confirmation:'password', terms_of_service:'yes' ,privacy_policy:'yes', identification:'senior', description: 'I will be willing to travel to take care of individuals, take them on a walk and also for shopping', address: Faker::Address.street_address, city:'Oakland', state:'California', fee: '20', dob: '08/12/1986',availability: true})
# Database Task Seed Data - MUST BE SEEDED INTO PRODUCTION:
  Service.create!(name: 'Companionship')   #service_id = 1
  Service.create!(name: 'Travel')          #service_id = 2
  Service.create!(name: 'Shopping')        #service_id = 3
  Service.create!(name: 'Housekeeping')    #service_id = 4
  Service.create!(name: 'Meal Prep')       #service_id = 5
  Service.create!(name: 'Errands')         #service_id = 6
  Service.create!(name: 'Yardwork')        #service_id = 7
  Task.create!(name: 'Socialization', service_id: 1)
  Task.create!(name: 'Movies', service_id: 1)
  Task.create!(name: 'Events', service_id: 1)
  Task.create!(name: 'Drive Your Ride', service_id: 2)
  Task.create!(name: 'Ride Share Services', service_id: 2)
  Task.create!(name: 'Malls', service_id: 3)
  Task.create!(name: 'Flea Markets', service_id: 3)
  Task.create!(name: 'Laundry', service_id: 4)
  Task.create!(name: 'Vacuum', service_id: 4)
  Task.create!(name: 'Light Cleaning', service_id: 4)
  Task.create!(name: 'Cooking', service_id: 5)
  Task.create!(name: 'Vegetable Mixing', service_id: 5)
  Task.create!(name: 'Grocery Shopping', service_id: 6)
  Task.create!(name: 'Doctors Appointments', service_id: 6)
  Task.create!(name: 'Gardening', service_id: 7)
  Task.create!(name: 'Lawnmowing', service_id: 7)
  Task.create!(name: 'Hedge Trimming', service_id: 7)






    # User.destroy_all
    # User.create([
    #   {
    #     first_name: 'clark', last_name: 'james', email:'clark@gmail.com', phone_number:'9485949383', password:'password', password_confirmation:'password', terms_of_service:'yes' ,privacy_policy:'yes', identification:'Companion', description: 'I will be willing to travel to take care of individuals, take them on a walk and also for shopping', address: Faker::Address.street_address, city:'Oakland', state:'California', fee: '20', dob: '08/12/1986',availability: true
    #   },
    #   {
    #     first_name: 'brian', last_name: 'bill', email:'brian@gmail.com', phone_number:'9485949383', password:'password', password_confirmation:'password', terms_of_service:'yes' ,privacy_policy:'yes', identification:'Companion', description: 'I will be willing to travel to take care of individuals, take them on a walk and also for shopping', address: Faker::Address.street_address, city:'Oakland', state:'California', fee: '20', dob: '08/12/1986',availability: true
    #   },
    #   {
    #     first_name: 'sean', last_name: 'smith', email:'smith@gmail.com', phone_number:'9485949383', password:'password', password_confirmation:'password', terms_of_service:'yes' ,privacy_policy:'yes', identification:'Companion', description: 'I will be willing to travel to take care of individuals, take them on a walk and also for shopping', address: Faker::Address.street_address, city:'Oakland', state:'California', fee: '20', dob: '08/12/1986',availability: true
    #   },
    #   {
    #     first_name: 'peter', last_name: 'lark', email:'peter@gmail.com', phone_number:'9485949383', password:'password', password_confirmation:'password', terms_of_service:'yes' ,privacy_policy:'yes', identification:'Companion', description: 'I will be willing to travel to take care of individuals, take them on a walk and also for shopping', address: Faker::Address.street_address, city:'Oakland', state:'California', fee: '25', dob: '08/12/1986',availability: true
    #   },
    #   {
    #     first_name: 'blake', last_name: 'shelton', email:'blake@gmail.com', phone_number:'9485949383', password:'password', password_confirmation:'password', terms_of_service:'yes' ,privacy_policy:'yes', identification:'Companion', description: 'I will be willing to travel to take care of individuals, take them on a walk and also for shopping', address: Faker::Address.street_address, city:'Oakland', state:'California', fee: '25', dob: '08/12/1986',availability: true
    #   },
    #   {
    #     first_name: 'black', last_name: 'white', email:'black@gmail.com', phone_number:'9485949383', password:'password', password_confirmation:'password', terms_of_service:'yes' ,privacy_policy:'yes', identification:'Companion', description: 'I will be willing to travel to take care of individuals, take them on a walk and also for shopping', address: Faker::Address.street_address, city:'Oakland', state:'California', fee: '19', dob: '08/12/1986',availability: true
    #   },
    #   {
    #     first_name: 'jack', last_name: 'london', email:'jack@gmail.com', phone_number:'9485949383', password:'password', password_confirmation:'password', terms_of_service:'yes' ,privacy_policy:'yes', identification:'Companion', description: 'I will be willing to travel to take care of individuals, take them on a walk and also for shopping', address: Faker::Address.street_address, city:'Oakland', state:'California', fee:'21', dob: '08/12/1986',availability: true
    #   }
    # ])
    # 100.times do
    #   User.create({first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email:Faker::Name.first_name + '@gmail.com', phone_number:'9485949383', password:'password', password_confirmation:'password', terms_of_service:'yes' ,privacy_policy:'yes', identification:'Companion', description: 'I will be willing to travel to take care of individuals, take them on a walk and also for shopping', address: Faker::Address.street_address, city:'Oakland', state:'California', fee:'21', dob: '08/12/1986',availability: true})
    # end
    # 100.times do
    #   User.create({first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email:Faker::Name.first_name + '@gmail.com', phone_number:'9485949383', password:'password', password_confirmation:'password', terms_of_service:'yes' ,privacy_policy:'yes', identification:'Companion', description: 'I will be willing to travel to take care of individuals, take them on a walk and also for shopping', address: Faker::Address.street_address, city:'Oakland', state:'California', fee:'23', dob: '08/12/1986',availability: true})
    # end
    # 100.times do
    #   User.create({first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email:Faker::Name.first_name + '@gmail.com', phone_number:'9485949383', password:'password', password_confirmation:'password', terms_of_service:'yes' ,privacy_policy:'yes', identification:'Companion', description: 'I will be willing to travel to take care of individuals, take them on a walk and also for shopping', address: Faker::Address.street_address, city:'Oakland', state:'California', fee:'20', dob: '08/12/1986',availability: true})
    # end
    # 150.times do
    #   User.create({first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email:Faker::Name.first_name + '@gmail.com', phone_number:'9485949383', password:'password', password_confirmation:'password', terms_of_service:'yes' ,privacy_policy:'yes', identification:'Senior', description: 'I will be willing to travel to take care of individuals, take them on a walk and also for shopping', address: Faker::Address.street_address, city:'Oakland', state:'California', dob: '08/12/1966',availability: true})
    # end

    # Seed for Blog testing:
    # 100.times do
    #   Blog.create!(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraphs)
    # end
    # 100.times do
    #   Blog.create!(title: Faker::Hipster.sentence(3), body: Faker::Hipster.paragraph(10, true, 10), image: Faker::LoremPixel.image("1000x600"))
    # end
