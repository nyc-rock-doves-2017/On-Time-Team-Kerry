Contractor.delete_all
Merchant.delete_all
Order.delete_all

Contractor.create(
  name: "Awaiting Assignment",
  email: Faker::Internet.email,
  password: "password",
  status: true
)

20.times do
  Contractor.create(
    name: Faker::Ancient.primordial,
    email: Faker::Internet.email,
    password: "password",
    status: true
  )
end

10.times do
  Merchant.create(
    name: Faker::Ancient.god,
    address: Faker::Address.street_address,
    email: Faker::Internet.email,
    password: "password"
  )
end

# Orders that have not been claimed
Order.create(merchant_id: 1, contractor_id: 2, destination: "Order One")
Order.create(merchant_id: 1, contractor_id: 3, destination: "Order Two")

# Orders that have been claimed but have not been picked up
Order.create(merchant_id: 1, contractor_id: 2, destination: "Order Three", claim_time: Time.new, pick_up_time: Time.new+rand(100), delivery_time: Time.new+rand(400))
Order.create(merchant_id: 1, contractor_id: 2, destination: "Order Four", claim_time: Time.new)

# Orders that have been claimed, picked up, but not delivered

# Orders that have been claimed, picked up, and delivered
