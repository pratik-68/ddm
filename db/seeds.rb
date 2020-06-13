# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Verification.create!(
  [
    { email: 'seller@gmail.com', status: :active },
    { email: 'buyer@gmail.com', status: :active },
    { email: 'both@gmail.com', status: :active },
    { email: 'abcd@gmail.com' }
  ]
)

User.create!(
  [
    {
      first_name: 'Seller',
      last_name: 'Ken',
      email: Verification.first.email,
      mobile_number: '9000000001',
      address: 'address 1',
      type_of_user: 'seller',
      password: '12345678',
      password_confirmation: '12345678'
    },
    {
      first_name: 'Buyer',
      last_name: 'Mark',
      email: Verification.second.email,
      mobile_number: '9000000002',
      address: 'address 2',
      type_of_user: 'buyer',
      password: '12345678',
      password_confirmation: '12345678' },
    {
      first_name: 'Both',
      last_name: 'Adem',
      email: Verification.third.email,
      mobile_number: '9000000003',
      address: 'address 3',
      type_of_user: 'both',
      password: '12345678',
      password_confirmation: '12345678' }
  ]
)

Token.create!(user: User.first)

Item.create!(
  [
    {
      name: 'Car',
      description: '4 setter car',
      max_amount: 300_000,
      status: :newItem,
      quantity: 1,
      bidding_end_time: Time.current + 3.hour,
      user: User.second
    },
    {
      name: 'Car 2',
      description: '4 setter car',
      max_amount: 300_000,
      status: :newItem,
      quantity: 1,
      bidding_end_time: Time.current + 3.hour,
      user: User.second
    },
    {
      name: 'Car 3',
      description: '4 setter car',
      max_amount: 300_000,
      status: :newItem,
      quantity: 1,
      bidding_end_time: Time.current + 3.hour,
      user: User.second
    },
    {
      name: 'Car 4',
      description: '4 setter car',
      max_amount: 300_000,
      status: :newItem,
      quantity: 1,
      bidding_end_time: Time.current + 3.hour,
      user: User.second
    },
    {
      name: 'Car 5',
      description: '4 setter car',
      max_amount: 300_000,
      status: :newItem,
      quantity: 1,
      bidding_end_time: Time.current + 3.hour,
      user: User.second
    },
    {
      name: 'Car 6',
      description: '4 setter car',
      max_amount: 300_000,
      status: :newItem,
      quantity: 1,
      bidding_end_time: Time.current + 3.hour,
      user: User.second
    },
    {
      name: 'TV',
      description: 'Big screen tv',
      max_amount: 10000,
      status: :oldItem,
      quantity: 1,
      bidding_end_time: Time.current + 1.day,
      user: User.third
    }
  ]
)

Bid.create!(
  [
    {
      name: 'Car 2000',
      amount: 200_000.00,
      user: User.first,
      item: Item.first
    },
    {
      name: 'Tv x20',
      amount: 5000.00,
      user: User.third,
      item: Item.first
    }
  ]
)
