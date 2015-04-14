require 'faker'

User.all.each { |user| user.delete }
Wiki.all.each { |wiki| wiki.delete }

#Create users
me = User.new(
  :name     => "Stephen",
  :email    => "stephen.m.cabrera@gmail.com",
  :password => "password",
  :role     => "admin"
)
me.skip_confirmation!
me.save

free_user = User.new(
  :name  => Faker::Name.name,
  :email    => "free@example.com",
  :password => "password",
  :role     => "free"
)
free_user.skip_confirmation!
free_user.save

premium_user = User.new(
  :name  => Faker::Name.name,
  :email => "premium@example.com",
  :password => "password",
  :role => "premium"
)
premium_user.skip_confirmation!
premium_user.save

admin_user = User.new(
  :name  => Faker::Name.name,
  :email => "admin@example.com",
  :password => "password",
  :role => "admin"
)
admin_user.skip_confirmation!
admin_user.save

users = [free_user, premium_user, admin_user]

users.each do |user|
  Wiki.create(
    title: "Public Wiki",
    body: "Body text",
    private: false,
    user_id: user.id
  )
end

users.each do |user|
  Wiki.create(
    title: "Private Wiki",
    body: "Body text",
    private: true,
    user_id: user.id
  )
end

puts "Seed finished"
puts "#{User.all.count} users created"
puts "#{Wiki.all.count} wikis created"



