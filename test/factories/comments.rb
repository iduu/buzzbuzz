Factory.define :comment do |c|
  c.text { |c| Factory.next :text }
end