require 'factory_girl'

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

Factory.define :vote do |v|
end

Factory.sequence :url do |n|
  "http://www.google.com/#{n}"
end

Factory.sequence :text do |n|
  "this is text#{n}"
end

Factory.sequence :title do |n|
  "this is title#{n}"
end

Factory.define :topic do |t|
  t.title { |t| Factory.next :title }
  t.url { |t| Factory.next :url }
  t.text { |t| Factory.next :text }
end

Factory.define :topic_with_author, :parent => :topic do |t|
  t.author {|t| t.association(:user)}
end

Factory.define :comment do |c|
  c.text { |c| Factory.next :text }
end