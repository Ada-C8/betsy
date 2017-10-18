# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Merchants: 21, 22
merchants = Merchant.create([
  { username: 'Eagle', email: 'watchingyou@gmail.com', id: 11, oauth_provider: 'github', oauth_uid: '123456', created_at: Time.now, updated_at: Time.now },
  { username: 'Glimpie', email: 'mememe@hotmail.com', id: 12, oauth_provider: 'github', oauth_uid: '123457', created_at: Time.now, updated_at: Time.now },
  { username: 'Earthborn King', email: 'eking@something.com', id: 13, oauth_provider: 'github', oauth_uid: '123458', created_at: Time.now, updated_at: Time.now },
  { username: 'MagicBrian', email: 'brian@spider.com', id: 21, oauth_provider: 'github', oauth_uid: '123459', created_at: Time.now, updated_at: Time.now },
  { username: 'Taako', email: 'abra@cafu.com', id: 22, oauth_provider: 'github', oauth_uid: '123460', created_at: Time.now, updated_at: Time.now },
  { username: 'Forest Nymph', email: 'inatree@treepeople.com', id: 31, oauth_provider: 'github', oauth_uid: '123461', created_at: Time.now, updated_at: Time.now },
  { username: 'Bridge Troll', email: 'trolltoll@bridge.com', id: 32, oauth_provider: 'github', oauth_uid: '123462', created_at: Time.now, updated_at: Time.now },
  { username: 'Puck', email: 'sneakyelf@shakespeare.com', id: 40, oauth_provider: 'github', oauth_uid: '123463', created_at: Time.now, updated_at: Time.now }
  ])

# Orders: 21, 22, 23, 24
orders = Order.create([
  { cust_name: 'Elvy', status: 'paid', cust_email: 'elvii@gmail.com', cust_cc: '11111000000', cust_cc_exp: '02/18', cust_addr: 'Elves Land', id: 11, created_at: Time.now, updated_at: Time.now },
  { cust_name: 'Earthborn King', status: 'paid', cust_email: 'eking@something.com', cust_cc: '22222220000000', cust_cc_exp: '10/19', cust_addr: 'Magestic Castle VI', id: 12, created_at: Time.now, updated_at: Time.now },
  { cust_name: 'Eagle', status: 'completed', cust_email: 'watchingyou@gmail.com', cust_cc: '3333333000000', cust_cc_exp: '04/18', cust_addr: '2nd Rock ', id: 13, created_at: Time.now, updated_at: Time.now },
  { cust_name: 'Maeraly', status: 'completed', cust_email: 'maeraly@hotmail.com', cust_cc: '4444000000', cust_cc_exp: '02/21', cust_addr: '123 75th Line ', id: 14, created_at: Time.now, updated_at: Time.now },
  { cust_name: 'Sar Squatch', status: 'completed', cust_email: 'big@feet.com', cust_cc: '1234567890', cust_cc_exp: '06/19', cust_addr: 'The Woods', id: 21, created_at: Time.now, updated_at: Time.now },
  { cust_name: 'Ponyboy', status: 'paid', cust_email: 'big@feet.com', cust_cc: '1234552567890', cust_cc_exp: '06/19', cust_addr: 'Cartoon Network', id: 22, created_at: Time.now, updated_at: Time.now },
  { cust_name: 'Maleficent', status: 'completed', cust_email: 'veryevilfairy@hotmail.com', cust_cc: '1234567823423490', cust_cc_exp: '04/25', cust_addr: '12345 Perceforest', id: 23, created_at: Time.now, updated_at: Time.now },
  { cust_name: 'Witchy Witcherson', status: 'completed', cust_email: 'witch@witch.com', cust_cc: '1234567890234234', cust_cc_exp: '06/22', cust_addr: '294 Witch St, Witchville', id: 24, created_at: Time.now, updated_at: Time.now },
  { cust_name: 'Angry Waitress', status: 'completed', cust_email: 'dontmesswithbess@restaurant.com', cust_cc: '1234567890', cust_cc_exp: '10/90', cust_addr: 'The Restaurant', id: 33, created_at: Time.now, updated_at: Time.now },
  { cust_name: 'DND Master', status: 'paid', cust_email: 'dragon_person@email.com', cust_cc: '1234567890', cust_cc_exp: '10/20', cust_addr: 'Fantasy Land', id: 34, created_at: Time.now, updated_at: Time.now },
  { cust_name: 'Ialways Wearmask', status: 'completed', cust_email: 'standingoveryouwiththatcreepymask@yourhouse.com', cust_cc: '1234567890', cust_cc_exp: '10/20', cust_addr: 'Charbroiled Goodness St', id: 35, created_at: Time.now, updated_at: Time.now },
  { cust_name: 'Hermit Wizard', status: 'completed', cust_email: 'lookingforlove@lonelyville.com', cust_cc: '1234567890', cust_cc_exp: '10/20', cust_addr: 'The cave', id: 36, created_at: Time.now, updated_at: Time.now }
  ])

# Products: 21, 22, 23, 24
products = Product.create([
  { name: 'Peaches of Immortality ', image_url: 'http://4.bp.blogspot.com/-5GQ1fBLNVr4/UAM6EnUpUSI/AAAAAAAAEyg/XKNYdq4P8x4/s1600/6a00e55119b5ec8834012877293a88970c-800wi.jpg', price: 3.25, quantity: 120, description: "Magical powers of immortality given from one bite", id: 11, created_at: Time.now, updated_at: Time.now, merchant_id: 21  },
  { name: 'That Ring', image_url: 'https://listverse.com/wp-content/uploads/2013/08/the-one-ring-e1375311691730.jpg', price: 350.00, quantity: 1, description: "The ring that gives you invisibility", id: 12, created_at: Time.now, updated_at: Time.now, merchant_id: 21  },
  { name: 'Dragon\'s Tooth', image_url: 'https://img1.etsystatic.com/100/0/9170080/il_340x270.831176717_5zaz.jpg', price: 9.99, quantity: 4, description: "Gives magical powers to it's owner.", id: 13, created_at: Time.now, updated_at: Time.now, merchant_id: 21  },
  { name: 'Helm of Darkness', image_url: 'http://cdn3.list25.com/wp-content/uploads/2017/04/HELMOFDARKNESSorsimilarmaybesubstituted-610x610.jpg', price: 49.99, quantity: 25, description: "Turn into a shadow with this magical helmet.", id: 14, created_at: Time.now, updated_at: Time.now , merchant_id: 11 },
  { name: 'Umbra Staff', image_url: 'https://image.freepik.com/free-photo/umbrella-closed_19-121570.jpg', price: 693.39, quantity: 10, description: "This is a supremely powerful magic wand, imbued with the soul of a great wizard. It's definitely not just an umbrella.", id: 21, created_at: Time.now, updated_at: Time.now, merchant_id: 22  },
  { name: 'My Little Pony (REAL)', image_url: 'https://lilyladewig.files.wordpress.com/2009/04/glitter-pony-2.jpg', price: 123.45, quantity: 100, description: "REAL PONY REAL MAGIC!! NOT FAKE", id: 22, created_at: Time.now, updated_at: Time.now, merchant_id: 21  },
  { name: 'Witch\'s Tears', image_url: 'https://i.ebayimg.com/images/g/BlsAAOSwWnFV84vC/s-l300.jpg', price: 21.21, quantity: 50, description: "You have to be really mean to a witch to make these.", id: 23, created_at: Time.now, updated_at: Time.now, merchant_id: 21  },
  { name: 'Golden Fleece', image_url: 'https://i.imgur.com/UMHsPJn.jpg', price: 5000.39 , quantity: 1, description: "Fresh Golden Fleece.", id: 37, created_at: Time.now, updated_at: Time.now, merchant_id: 11   },
  { name: 'Excalibur', image_url: 'https://i.imgur.com/2cGiWjQ.jpg?1', price: 50.01, quantity: 1, description: "Do you want to be the King of Camelot?  Here is your chance.", id: 38, created_at: Time.now, updated_at: Time.now, merchant_id: 31 },
  { name: 'Ghost of Caesar in a Mason Jar', image_url: 'https://i.imgur.com/ys1of8Rr.jpg', price: 2145.96, quantity: 1, description: "There are so many uses for this ghost in a jar.  Are you interested in learning Latin?  Have someone you really need to scare?  This ghost will haunt like none other.  Just open the jar and your home, work, or back yard is haunted by Julius Caesar.  You'll be saying 'E Tu, Brute' in no time.", id: 39, created_at: Time.now, updated_at: Time.now, merchant_id: 31  },
  { id: 1, name: 'Monkey\'s  Paw', image_url: 'https://theluckycandle.com/wp-content/uploads/2014/07/Monkey-Paw-.jpg', price: 777.00, quantity: 60, description: 'The paw of a monkey, said to grant any wish in unfathomable ways.(Seller does not take any responsibility for the outcome of said wishes)', created_at: Time.now, updated_at: Time.now, merchant_id: 31 },
  { id: 2, name: 'Bloodied Parchments of Merlin', image_url: 'https://orig00.deviantart.net/e72e/f/2011/259/a/1/bloody_parchment_by_shinjite_samachan-d4a2dlf.jpg', price: 20, quantity: 300, description: 'Parchments said to come from the infamous wizard himself. Papers are bloodied to the point of illegibility.', created_at: Time.now, updated_at: Time.now, merchant_id: 13 },
  { id: 3, name: 'Golden Saddles of Mercury', image_url: 'https://i.pinimg.com/736x/3a/b2/b6/3ab2b6bc38cc66bbdad7c4cca2b02812.jpg', price: 104.67, quantity: 9, description: 'Sturdy leather saddle set for horse-riding enthusiasts. Recommended for winged steeds.', created_at: Time.now, updated_at: Time.now, merchant_id: 31 },
  { id: 4, name: 'Mermaid Fin', image_url: 'https://www.finfunmermaid.com/images/products/dragonfly-mermaid-tail_category.jpg?resizeid=4&resizeh=399&resizew=399', price: 35.00, quantity: 2017, description: 'Fins collected from mermaids who decided to give up their underwater life to be where the (land) people are.', created_at: Time.now, updated_at: Time.now, merchant_id: 12 }
  ])

order_products = OrderProduct.create([
  { status: 'shipped', quantity: '1', order_id: 24, product_id: 21, created_at: Time.now, updated_at: Time.now, id: 21 },
  { status: 'shipped', quantity: '3', order_id: 24, product_id: 23, created_at: Time.now, updated_at: Time.now, id: 22 },
  { status: 'shipped', quantity: '1', order_id: 22, product_id: 22, created_at: Time.now, updated_at: Time.now, id: 23 },
  { status: 'shipped', quantity: '3', order_id: 21, product_id: 23, created_at: Time.now, updated_at: Time.now, id: 24 },
  { status: 'shipped', quantity: '1', order_id: 23, product_id: 21, created_at: Time.now, updated_at: Time.now, id: 25 }
  ])

reviews = Review.create([
  { rating: 5, description: 'very nice and magic', product_id: 22, created_at: Time.now, updated_at: Time.now, id: 21 },
  { rating: 1, description: 'these are wizards tears, NOT witch\'s tears. seller should be ashamed', product_id: 23, created_at: Time.now, updated_at: Time.now, id: 22 }
  ])
