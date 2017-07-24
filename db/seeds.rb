Contractor.delete_all
Merchant.delete_all

20.times do
  Contractor.create(
    name: Faker::Ancient.primordial,
    email: Faker::Internet.email,
    password: "password"
  )
end

10.times do
  Merchant.create(
    name: Faker::Ancient.god,
    address: Faker::Lorem.sentences,
    email: Faker::Internet.email,
    password: "password"
  )
end
