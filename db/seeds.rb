
# db/seeds.rb (append)


User.find_or_create_by!(email: "chrisafunk@gmail.com") do |u|
  u.first_name = "Chris",
  u.last_name = "Funk"
  u.password = "password"
  u.password_confirmation = "password"
  u.role = :admin
end
