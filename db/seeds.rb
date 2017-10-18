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
  { username: 'Taako', email: 'abra@cafu.com', id: 22, created_at: Time.now, updated_at: Time.now },
  { username: 'Forest Nymph', email: 'inatree@treepeople.com', id: 31, created_at: Time.now, updated_at: Time.now },
  { username: 'Bridge Troll', email: 'trolltoll@bridge.com', id: 32, created_at: Time.now, updated_at: Time.now },
  { username: 'Puck', email: 'sneakyelf@shakespeare.com', id: 40, created_at: Time.now, updated_at: Time.now }
  ])

# Orders: 21, 22, 23, 24
orders = Order.create([
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
  { name: 'Umbra Staff', image_url: 'https://image.freepik.com/free-photo/umbrella-closed_19-121570.jpg', price: 693.39, quantity: 10, description: "This is a supremely powerful magic wand, imbued with the soul of a great wizard. It's definitely not just an umbrella.", id: 21, created_at: Time.now, updated_at: Time.now, merchant_id: 22  },
  { name: 'My Little Pony (REAL)', image_url: 'https://lilyladewig.files.wordpress.com/2009/04/glitter-pony-2.jpg', price: 123.45, quantity: 100, description: "REAL PONY REAL MAGIC!! NOT FAKE", id: 22, created_at: Time.now, updated_at: Time.now, merchant_id: 21  },
  { name: 'Witch\'s Tears', image_url: 'https://i.ebayimg.com/images/g/BlsAAOSwWnFV84vC/s-l300.jpg', price: 21.21, quantity: 50, description: "You have to be really mean to a witch to make these.", id: 23, created_at: Time.now, updated_at: Time.now, merchant_id: 21  },
  { name: 'Golden Fleece', image_url: 'https://i.imgur.com/UMHsPJn.jpg', price: 5000.39 , quantity: 1, description: "Fresh Golden Fleece.", id: 37, created_at: Time.now, updated_at: Time.now  },
  { name: 'Excalibur', image_url: 'https://i.imgur.com/2cGiWjQ.jpg?1', price: 50.01, quantity: 1, description: "Do you want to be the King of Camelot?  Here is your chance.", id: 38, created_at: Time.now, updated_at: Time.now  },
  { name: 'Ghost of Caesar in a Mason Jar', image_url: 'https://i.imgur.com/ys1of8Rr.jpg', price: 2145.96, quantity: 1, description: "There are so many uses for this ghost in a jar.  Are you interested in learning Latin?  Have someone you really need to scare?  This ghost will haunt like none other.  Just open the jar and your home, work, or back yard is haunted by Julius Caesar.  You'll be saying 'E Tu, Brute' in no time.", id: 39, created_at: Time.now, updated_at: Time.now  },
  { id: 1, name: 'Monkey\'s Paw', image_url: 'https://theluckycandle.com/wp-content/uploads/2014/07/Monkey-Paw-.jpg', price: 777.00, quantity: 60, description: 'The paw of a monkey, said to grant any wish in unfathomable ways.(Seller does not take any responsibility for the outcome of said wishes)', created_at: Time.now, updated_at: Time.now },
  { id: 2, name: 'Bloodied Parchments of Merlin', image_url: 'https://orig00.deviantart.net/e72e/f/2011/259/a/1/bloody_parchment_by_shinjite_samachan-d4a2dlf.jpg', price: 20, quantity: 300, description: 'Parchments said to come from the infamous wizard himself. Papers are bloodied to the point of illegibility.', created_at: Time.now, updated_at: Time.now },
  { id: 3, name: 'Golden Saddles of Mercury', image_url: 'https://i.pinimg.com/736x/3a/b2/b6/3ab2b6bc38cc66bbdad7c4cca2b02812.jpg', price: 104.67, quantity: 9, description: 'Sturdy leather saddle set for horse-riding enthusiasts. Recommended for winged steeds.', created_at: Time.now, updated_at: Time.now },
  { id: 4, name: 'Mermaid Fin', image_url: 'https://www.finfunmermaid.com/images/products/dragonfly-mermaid-tail_category.jpg?resizeid=4&resizeh=399&resizew=399', price: 35.00, quantity: 2017, description: 'Fins collected from mermaids who decided to give up their underwater life to be where the (land) people are.', created_at: Time.now, updated_at: Time.now }
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
