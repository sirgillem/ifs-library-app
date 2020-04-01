# Create an admin user
User.create!(username: 'Admin',
             email: 'webmaster@infullswing.org.au',
             password: 'foobar',
             password_confirmation: 'foobar',
             admin: true,
             librarian: true)

# Create a librarian user
User.create!(username: 'Librarian',
             email: 'librarian@infullswing.org.au',
             password: 'library',
             password_confirmation: 'library',
             librarian: true)

# Create some more users
20.times do |n|
  username = Faker::Artist.name
  email = "example-#{n+1}@infullswing.org.au"
  password = 'password'
  User.create!(username: username,
               email: email,
               password: password,
               password_confirmation: password)
end
