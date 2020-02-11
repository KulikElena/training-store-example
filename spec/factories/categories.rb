FactoryBot.define do
  factory :category do
    title { ['Mobile development', 'Web development', 'Web design', 'Photo'].sample }
    slug { FFaker::Internet.slug }
  end
end
