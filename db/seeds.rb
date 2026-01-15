
# db/seeds.rb (append)


User.find_or_create_by!(email: "chrisafunk@gmail.com") do |u|
  u.password = "password"
  u.password_confirmation = "password"
  u.role = :admin
end
