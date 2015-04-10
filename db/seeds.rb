
free_user = User.new(
  :email => "free@example.com",
  :password => "password",
  :role => "free"
)
free_user.skip_confirmation!
free_user.save

premium_user = User.new(
  :email => "premium@example.com",
  :password => "password",
  :role => "premium"
)
premium_user.skip_confirmation!
premium_user.save

admin_user = User.new(
  :email => "admin@example.com",
  :password => "password",
  :role => "admin"
)
admin_user.skip_confirmation!
admin_user.save

users = [free_user, premium_user, admin_user]
users.each do |user|
  Wiki.create(
    title: "Public Post by #{user.email}",
    body: "Body text",
    private: false,
    user_id: user.id
  )
end

users.each do |user|
  Wiki.create(
    title: "Private Post by #{user.email}",
    body: "Body text",
    private: true,
    user_id: user.id
  )
end

