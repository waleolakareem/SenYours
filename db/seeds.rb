require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
    User.destroy_all
    User.create([
      {
        first_name: 'clark', last_name: 'james', email:'clark@gmail.com', phone_number:'9485949383', password:'password', password_confirmation:'password', terms_of_service:'yes' ,privacy_policy:'yes', identification:'Companion', description: 'I will be willing to travel to take care of individuals, take them on a walk and also for shopping', address: Faker::Address.street_address, city:'Oakland', state:'California', fee: '20', dob: '08/12/1986'
      },
      {
        first_name: 'brian', last_name: 'bill', email:'brian@gmail.com', phone_number:'9485949383', password:'password', password_confirmation:'password', terms_of_service:'yes' ,privacy_policy:'yes', identification:'Companion', description: 'I will be willing to travel to take care of individuals, take them on a walk and also for shopping', address: Faker::Address.street_address, city:'Oakland', state:'California', fee: '20', dob: '08/12/1986'
      },
      {
        first_name: 'sean', last_name: 'smith', email:'smith@gmail.com', phone_number:'9485949383', password:'password', password_confirmation:'password', terms_of_service:'yes' ,privacy_policy:'yes', identification:'Companion', description: 'I will be willing to travel to take care of individuals, take them on a walk and also for shopping', address: Faker::Address.street_address, city:'Oakland', state:'California', fee: '20', dob: '08/12/1986'
      },
      {
        first_name: 'peter', last_name: 'lark', email:'peter@gmail.com', phone_number:'9485949383', password:'password', password_confirmation:'password', terms_of_service:'yes' ,privacy_policy:'yes', identification:'Companion', description: 'I will be willing to travel to take care of individuals, take them on a walk and also for shopping', address: Faker::Address.street_address, city:'Oakland', state:'California', fee: '25', dob: '08/12/1986'
      },
      {
        first_name: 'blake', last_name: 'shelton', email:'blake@gmail.com', phone_number:'9485949383', password:'password', password_confirmation:'password', terms_of_service:'yes' ,privacy_policy:'yes', identification:'Companion', description: 'I will be willing to travel to take care of individuals, take them on a walk and also for shopping', address: Faker::Address.street_address, city:'Oakland', state:'California', fee: '25', dob: '08/12/1986'
      },
      {
        first_name: 'black', last_name: 'white', email:'black@gmail.com', phone_number:'9485949383', password:'password', password_confirmation:'password', terms_of_service:'yes' ,privacy_policy:'yes', identification:'Companion', description: 'I will be willing to travel to take care of individuals, take them on a walk and also for shopping', address: Faker::Address.street_address, city:'Oakland', state:'California', fee: '19', dob: '08/12/1986'
      },
      {
        first_name: 'jack', last_name: 'london', email:'jack@gmail.com', phone_number:'9485949383', password:'password', password_confirmation:'password', terms_of_service:'yes' ,privacy_policy:'yes', identification:'Companion', description: 'I will be willing to travel to take care of individuals, take them on a walk and also for shopping', address: Faker::Address.street_address, city:'Oakland', state:'California', fee:'21', dob: '08/12/1986'
      }
    ])
