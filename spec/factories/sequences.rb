Factory.sequence(:email) do |email|
  "Algum.#{email}@gmail.com"
end

Factory.sequence(:nome) do |nome|
  "Alguem #{nome}"
end