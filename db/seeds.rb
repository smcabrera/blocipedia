require 'faker'

User.all.each { |user| user.delete }
Wiki.all.each { |wiki| wiki.delete }

#I'm the admin
me = User.new(
  :name     => "Stephen",
  :email    => "stephen.m.cabrera@gmail.com",
  :password => "password",
  :role     => "admin"
)
me.skip_confirmation!
me.save

# Create a free user
free_user = User.new(
  :name  => Faker::Name.name,
  :email    => "free@example.com",
  :password => "password",
  :role     => "free"
)
free_user.skip_confirmation!
free_user.save

# Create some premium users
premium_user = User.new(
  :name     => Faker::Name.name,
  :email    => 'premium@example.com',
  :password => 'password',
  :role     => "premium"
)
premium_user.skip_confirmation!
premium_user.save

5.times do
  user = User.new(
  :name  => Faker::Name.name,
  :email => Faker::Internet.email,
  :password => "password",
  :role => "premium"
)
  user.skip_confirmation!
  user.save
end

premium_users = User.where(:role => "premium")

admin_user = User.new(
  :name  => Faker::Name.name,
  :email => "admin@example.com",
  :password => "password",
  :role => "admin"
)
admin_user.skip_confirmation!
admin_user.save

#users = [free_user, premium_user, admin_user]

# Create some wikis for our users

# First everyone makes a public wiki
#users.each do |user|
  #Wiki.create(
    #title: "Public Wiki",
    #body: "Body text",
    #private: false,
    #user_id: user.id
  #)
#end

#Now premium user and admin user make private wikis
#users.each do |user|
  #Wiki.create(
    #title: "Private Wiki",
    #body: "Body text",
    #private: true,
    #user_id: user.id
  #)
#end

puts "Seed finished"
puts "#{User.all.count} users created"
puts "#{Wiki.all.count} wikis created"



