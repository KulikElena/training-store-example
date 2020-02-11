FactoryBot.define do
  factory :book do
    slug { FFaker::Internet.slug }
    publication_year { FFaker::Vehicle.year }
    material { 'cotton' }
    width { 10.2 }
    height { 3 }
    depth { 15 }
    sold { 0 }
    quantity { 20 }
    description { FFaker::Book.description }
    price { (20..100).to_a.sample }
    title { FFaker::Book.title }
    association(:category)
  end
end
