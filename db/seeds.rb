require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
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

    # Blaine's User Seed so when he resets the db he does not have to reenter it each time! PLEASE DONT DELETE ME!
    # User.create({ first_name: "Kelli", last_name: "Potter", email: 'Kellipotter@gmail.com', phone_number:'4802583851', password:'kelli', password_confirmation:'kelli', terms_of_service:'yes' ,privacy_policy:'yes', identification:'Companion', description: 'I am more than happy to spend large amounts of time with my senior friends!', address: Faker::Address.street_address, city:'Oakland', state:'California', fee:'20', dob: '08/12/1986',availability: true })
    #
    # User.create({ first_name: "Blaine", last_name: "Anderson", email: 'BlaineA97@gmail.com', phone_number:'4803053307', password:'blaine', password_confirmation:'blaine', terms_of_service:'yes' ,privacy_policy:'yes', identification:'Senior', description: 'I cant wait to spend all of my time with my companion friend!', address: Faker::Address.street_address, city:'Oakland', state:'California', fee:'20', dob: '08/12/1986',availability: true })
