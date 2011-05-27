Factory.sequence :email do |n|
  "person#{n}@email.com"
end

Factory.sequence :username do |n|
  "bob#{n}"
end

Factory.define :user do |u|
  u.username { |u| Factory.next :username }
  u.password "test123456"
  u.password_confirmation "test123456"
  u.email { |u| Factory.next :email }
end