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

100.times do
  mercs = Merchant.all
  num = mercs.length
  mercs[0..num].sample.orders.create(
    destination: Faker::Address.street_address,
    claim_time: Time.now,
    pick_up_time: Time.now + (rand(1..5)).minutes,
    delivery_time: Time.now + (rand(5..27)).minutes,
    contractor: Contractor.all.sample
  )
end

# TO TEST NO PAGE WITH FAIL GUY

fail_guy = Contractor.create(
  name: "Fail Guy",
  email: 'i@fail.com',
  password: "password",
  status: true
)

10.times do
  Order.create(
  merchant: Merchant.all.sample,
  destination: 'fail',
  claim_time: Time.now,
  pick_up_time: Time.now + rand(60).minutes,
  delivery_time: Time.now + rand(120).minutes,
  contractor: fail_guy
                )
end

# Orders that have not been claimed
# Order.create(merchant_id: 1, contractor_id: 2, destination: "Order One")
# Order.create(merchant_id: 1, contractor_id: 3, destination: "Order Two")
#
# # Orders that have been claimed but have not been picked up
# Order.create(merchant_id: 1, contractor_id: 2, destination: "Order Three", claim_time: Time.new)
# Order.create(merchant_id: 1, contractor_id: 2, destination: "Order Four", claim_time: Time.new

# Orders that have been claimed, picked up, but not delivered

# Orders that have been claimed, picked up, and delivered
