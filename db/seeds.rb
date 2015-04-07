# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

free_user = User.new(:email => 'free@example.com', :password => 'password')
free_user.skip_confirmation!
free_user.save

Wiki.create(
  title: 'Public Post',
  body: 'Some text',
  private: false
)
Wiki.create(
  title: 'Private Post',
  body: 'Some text',
  private: true
)

