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