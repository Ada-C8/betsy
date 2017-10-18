# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Merchants: 21, 22
merchants = Merchant.create([
  { username: 'MagicBrian', email: 'brian@spider.com', id: 21, created_at: Time.now, updated_at: Time.now },
  { username: 'Taako', email: 'abra@cafu.com', id: 22, created_at: Time.now, updated_at: Time.now }
  ])

# Orders: 21, 22, 23, 24
orders = Order.create([
  { cust_name: 'Sar Squatch', status: 'completed', cust_email: 'big@feet.com', cust_cc: '1234567890', cust_cc_exp: '06/19', cust_addr: 'The Woods', id: 21, created_at: Time.now, updated_at: Time.now },
  { cust_name: 'Ponyboy', status: 'paid', cust_email: 'big@feet.com', cust_cc: '1234552567890', cust_cc_exp: '06/19', cust_addr: 'Cartoon Network', id: 22, created_at: Time.now, updated_at: Time.now },
  { cust_name: 'Maleficent', status: 'completed', cust_email: 'veryevilfairy@hotmail.com', cust_cc: '1234567823423490', cust_cc_exp: '04/25', cust_addr: '12345 Perceforest', id: 23, created_at: Time.now, updated_at: Time.now },
  { cust_name: 'Witchy Witcherson', status: 'completed', cust_email: 'witch@witch.com', cust_cc: '1234567890234234', cust_cc_exp: '06/22', cust_addr: '294 Witch St, Witchville', id: 24, created_at: Time.now, updated_at: Time.now }
  ])

# Products: 21, 22, 23, 24
products = Product.create([
  { name: 'Umbra Staff', image_url: 'https://image.freepik.com/free-photo/umbrella-closed_19-121570.jpg', price: 693.39, quantity: 1, description: "This is a supremely powerful magic wand, imbued with the soul of a great wizard. It's definitely not just an umbrella.", id: 21, created_at: Time.now, updated_at: Time.now  },
  { name: 'My Little Pony (REAL)', image_url: 'https://lilyladewig.files.wordpress.com/2009/04/glitter-pony-2.jpg', price: 123.45, quantity: 100, description: "REAL PONY REAL MAGIC!! NOT FAKE", id: 22, created_at: Time.now, updated_at: Time.now  },
  { name: 'Witch\'s Tears', image_url: 'https://i.ebayimg.com/images/g/BlsAAOSwWnFV84vC/s-l300.jpg', price: 21.21, quantity: 1, description: "This is a supremely powerful magic wand, imbued with the soul of a great wizard. It's definitely not just an umbrella.", id: 23, created_at: Time.now, updated_at: Time.now  }
  ])






# Products: 11, 12, 13, 14
 products = Product.create([
   { name: 'Peaches of Immortality ', image_url: 'http://4.bp.blogspot.com/-5GQ1fBLNVr4/UAM6EnUpUSI/AAAAAAAAEyg/XKNYdq4P8x4/s1600/6a00e55119b5ec8834012877293a88970c-800wi.jpg', price: 3.25, quantity: 120, description: "Magical powers of immortality given from one bite", id: 11, created_at: Time.now, updated_at: Time.now  },
   { name: 'That Ring', image_url: 'https://listverse.com/wp-content/uploads/2013/08/the-one-ring-e1375311691730.jpg', price: 350.00, quantity: 1, description: "The ring that gives you invisibility", id: 12, created_at: Time.now, updated_at: Time.now  },
   { name: 'Dragon\'s Tooth', image_url: 'https://img1.etsystatic.com/100/0/9170080/il_340x270.831176717_5zaz.jpg', price: 9.99, quantity: 4, description: "Gives magical powers to it's owner.", id: 13, created_at: Time.now, updated_at: Time.now  },
   { name: 'Helm of Darkness', image_url: 'http://cdn3.list25.com/wp-content/uploads/2017/04/HELMOFDARKNESSorsimilarmaybesubstituted-610x610.jpg', price: 49.99, quantity: 25, description: "Turn into a shadow with this magical helmet.", id: 14, created_at: Time.now, updated_at: Time.now  }
   ])


# Products: 11, 12, 13, 14
 orders = Order.create([
   { cust_name: 'Elvy', status: 'paid', cust_email: 'elvii@gmail.com', cust_cc: '11111000000', cust_cc_exp: '02/18', cust_addr: 'Elves Land', id: 11, created_at: Time.now, updated_at: Time.now },
   { cust_name: 'Earthborn King', status: 'paid', cust_email: 'eking@something.com', cust_cc: '22222220000000', cust_cc_exp: '10/19', cust_addr: 'Magestic Castle VI', id: 12, created_at: Time.now, updated_at: Time.now },
   { cust_name: 'Eagle', status: 'completed', cust_email: 'watchingyou@gmail.com', cust_cc: '3333333000000', cust_cc_exp: '04/18', cust_addr: '2nd Rock ', id: 13, created_at: Time.now, updated_at: Time.now },
   { cust_name: 'Maeraly', status: 'completed', cust_email: 'maeraly@hotmail.com', cust_cc: '4444000000', cust_cc_exp: '02/21', cust_addr: '123 75th Line ', id: 14, created_at: Time.now, updated_at: Time.now }
   ])

#Products: 11, 12, 13
 merchants = Merchant.create([
 { user_name: 'Eagle',cust_email: 'watchingyou@gmail.com', id: 11, created_at: Time.now, updated_at: Time.now },
 { username: 'Glimpie', email: 'mememe@hotmail.com', id: 12, created_at: Time.now, updated_at: Time.now },
 { username: 'Earthborn King', email: 'eking@something.com', id: 13, created_at: Time.now, updated_at: Time.now }

 ])
