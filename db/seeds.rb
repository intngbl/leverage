# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'role: ' << role
end

puts 'DEFAULT USERS'
user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
user.confirm!
puts 'user: ' << user.name
user.add_role :admin
agency = User.find_or_create_by_email :name => 'SEMANA', :email => 'fedecasas@gmail.com', :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
agency.confirm!
puts 'user: ' << agency.name
agency.add_role :agency

puts 'DEFAULT CAMPAIGNS'
agency.campaigns.delete_all
virgin = agency.campaigns.create title: "Experience Virgin America", brief: "The Virgin America experience is like no other airline's.", price: "9.99"
puts 'campaign: ' << virgin.title
nike = agency.campaigns.create title: "Nike at the Olympics", brief: "Don't dream of winning. Train for it.", price: "4.99"
puts 'campaign: ' << nike.title
