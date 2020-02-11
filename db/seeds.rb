BOOK_IMGS = [
  'https://gdurl.com/gphg',
  'https://gdurl.com/CZcD',
  'https://gdurl.com/0BSY',
  'https://gdurl.com/525U',
  'https://gdurl.com/hUyY',
  'https://gdurl.com/ucaQ',
  'https://gdurl.com/tiFk',
  'https://gdurl.com/s4xX',
  'https://gdurl.com/I1Jz',
  'https://gdurl.com/XoSU',
  'https://gdurl.com/pAD8',
  'https://gdurl.com/N4gb',
  'https://gdurl.com/p15l',
  'https://gdurl.com/PYWT',
  'https://gdurl.com/hf_k',
  'https://gdurl.com/mscc'
].freeze
EXTEND_BOOK_IMAGES = [
  'https://gdurl.com/SjK8',
  'https://gdurl.com/pMsz',
  'https://gdurl.com/EnLT',
  'https://gdurl.com/ep-L'
].freeze
BOOKS_TITELS = [
  'Tokyo Cat',
  'I am Death Witch',
  'Killer Thief',
  'Season of the Green Woman',
  'Planet of the Bloody Gypsy',
  'Hungry Wolves',
  'I am Nuclear Friday',
  'Fake Women',
  'Hungry Hills',
  'A Fistful of Danger Blow',
  'Nuclear Brains',
  'Champagne Ninjas',
  'Blue Wolves',
  'Nuclear World'
].freeze
BOOKS_PRICE = [7.27, 5.46, 9.88, 7.03, 5.75, 2.38, 5.66, 6.98, 5.25, 6.47, 3.62, 6.45, 6.18, 2.1].freeze
AUTHORS_FIRST_NAME = %w[
  Severus
  Billy
  Teddy
  Jonny
].freeze
AUTHORS_LAST_NAME = %w[
  Wonka
  Black
  Sparrow
  Wick
].freeze
['Mobile development',
 'Photo',
 'Web development',
 'Web design'].each { |category| Category.create!(title: category) }

DeliveryService.create(name: 'Novaposhta', price: 18.25, from_days: 3, to_days: 5)
DeliveryService.create(name: 'Ukr post', price: 28.5, from_days: 5, to_days: 7)

AUTHORS_FIRST_NAME.each_with_index do |first, index|
  Author.create!(
    first_name: first,
    last_name: AUTHORS_LAST_NAME[index]
  )
end

if Rails.env.production?
  15.times do
    book = Book.create!(title: FFaker::Book.title,
                        price: FFaker::PhoneNumber.area_code / 100.00,
                        description: FFaker::Lorem.paragraph(10),
                        quantity: FFaker::PhoneNumber.area_code,
                        category_id: rand(1..4),
                        publication_year: FFaker::Time.between('1992-01-01', Time.zone.now),
                        material: FFaker::LoremPL.word,
                        depth: FFaker::PhoneNumber.area_code,
                        width: FFaker::PhoneNumber.area_code,
                        height: FFaker::PhoneNumber.area_code)
    book.authors << Author.all.sample(rand(1..2))
  end
else
  6.times do
    book = Book.create!(title: BOOKS_TITELS[rand(0..13)],
                        price: BOOKS_PRICE[rand(0..13)],
                        description: "Tenetur est et voluptate sit. Quae dicta ipsa at quibusdam.
                        Delectus natus incidunt et non est perspiciatis.
                        Molestiae occaecati dolores architecto odit dolorem. Nostrum ut id tempore culpa similique maiores.
                        Omnis laboriosam nobis repellat culpa totam iusto facere. Dicta doloremque omnis dolores libero aspernatur
                        est atque perspiciatis. Sint hic odio error accusamus. Quas aut optio temporibus culpa.
                        Adipisci quidem corporis eum a vitae rerum aut culpa. Sunt qui doloremque cupiditate at eum.
                        Illum quis rem voluptatum mollitia et.",
                        quantity: rand(1..100),
                        category_id: rand(1..4),
                        publication_year: Time.zone.now,
                        material: 'paper',
                        sold: rand(1..50),
                        depth: 120,
                        width: 150,
                        height: 230)
    book.authors << Author.all.sample(rand(1..2))
    book.images.create(remote_image_url: BOOK_IMGS[rand(0..15)])
  end

  Book.all.each do |book_cur|
    4.times do
      book_cur.images.create(remote_image_url: EXTEND_BOOK_IMAGES[rand(0..3)])
    end
  end
end

User.create!(email: 'user@example.com', password: 'password', password_confirmation: 'password', admin: false)

if Rails.env.development?
  require 'ffaker'
  16.times do
    book = Book.create!(title: FFaker::Book.title,
                        price: FFaker::PhoneNumber.area_code / 100.00,
                        description: FFaker::Lorem.paragraph(10),
                        quantity: FFaker::PhoneNumber.area_code,
                        category_id: rand(1..4),
                        publication_year: FFaker::Time.between('1992-01-01', Time.zone.now),
                        material: FFaker::LoremPL.word,
                        depth: FFaker::PhoneNumber.area_code,
                        width: FFaker::PhoneNumber.area_code,
                        height: FFaker::PhoneNumber.area_code)
    book.authors << Author.all.sample(rand(1..2))
  end
end
User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', admin: true) if Rails.env.development?
