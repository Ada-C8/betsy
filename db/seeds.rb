# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

merchants = Merchant.create([
  { username: 'Eagle', email: 'watchingyou@gmail.com', id: 1, oauth_provider: 'github', oauth_uid: '123456', created_at: Time.now, updated_at: Time.now },
  { username: 'Glimpie', email: 'mememe@hotmail.com', id: 2, oauth_provider: 'github', oauth_uid: '123457', created_at: Time.now, updated_at: Time.now },
  { username: 'Earthborn King', email: 'eking@something.com', id: 3, oauth_provider: 'github', oauth_uid: '123458', created_at: Time.now, updated_at: Time.now },
  { username: 'MagicBrian', email: 'brian@spider.com', id: 4, oauth_provider: 'github', oauth_uid: '123459', created_at: Time.now, updated_at: Time.now },
  { username: 'Taako', email: 'abra@cafu.com', id: 5, oauth_provider: 'github', oauth_uid: '123460', created_at: Time.now, updated_at: Time.now },
  { username: 'Forest Nymph', email: 'inatree@treepeople.com', id: 6, oauth_provider: 'github', oauth_uid: '123461', created_at: Time.now, updated_at: Time.now },
  { username: 'Bridge Troll', email: 'trolltoll@bridge.com', id: 7, oauth_provider: 'github', oauth_uid: '123462', created_at: Time.now, updated_at: Time.now },
  { username: 'Puck', email: 'sneakyelf@shakespeare.com', id: 8, oauth_provider: 'github', oauth_uid: '123463', created_at: Time.now, updated_at: Time.now }
  ])

orders = Order.create([
  { cust_name: 'Elvy', status: 'paid', cust_email: 'elvii@gmail.com', cust_cc: '11111000000', cust_cc_exp: '02/18', cust_addr: 'Elves Land', id: 1, created_at: Time.now, updated_at: Time.now },
  { cust_name: 'Earthborn King', status: 'paid', cust_email: 'eking@something.com', cust_cc: '22222220000000', cust_cc_exp: '10/19', cust_addr: 'Magestic Castle VI', id: 2, created_at: Time.now, updated_at: Time.now },
  { cust_name: 'Eagle', status: 'completed', cust_email: 'watchingyou@gmail.com', cust_cc: '3333333000000', cust_cc_exp: '04/18', cust_addr: '2nd Rock ', id: 3, created_at: Time.now, updated_at: Time.now },
  { cust_name: 'Maeraly', status: 'completed', cust_email: 'maeraly@hotmail.com', cust_cc: '4444000000', cust_cc_exp: '02/21', cust_addr: '123 75th Line ', id: 4, created_at: Time.now, updated_at: Time.now },
  { cust_name: 'Sar Squatch', status: 'completed', cust_email: 'big@feet.com', cust_cc: '1234567890', cust_cc_exp: '06/19', cust_addr: 'The Woods', id: 5, created_at: Time.now, updated_at: Time.now },
  { cust_name: 'Ponyboy', status: 'paid', cust_email: 'big@feet.com', cust_cc: '1234552567890', cust_cc_exp: '06/19', cust_addr: 'Cartoon Network', id: 6, created_at: Time.now, updated_at: Time.now },
  { cust_name: 'Maleficent', status: 'completed', cust_email: 'veryevilfairy@hotmail.com', cust_cc: '1234567823423490', cust_cc_exp: '04/25', cust_addr: '12345 Perceforest', id: 7, created_at: Time.now, updated_at: Time.now },
  { cust_name: 'Witchy Witcherson', status: 'completed', cust_email: 'witch@witch.com', cust_cc: '1234567890234234', cust_cc_exp: '06/22', cust_addr: '294 Witch St, Witchville', id: 8, created_at: Time.now, updated_at: Time.now },
  { cust_name: 'Angry Waitress', status: 'completed', cust_email: 'dontmesswithbess@restaurant.com', cust_cc: '1234567890', cust_cc_exp: '10/90', cust_addr: 'The Restaurant', id: 9, created_at: Time.now, updated_at: Time.now },
  { cust_name: 'DND Master', status: 'paid', cust_email: 'dragon_person@email.com', cust_cc: '1234567890', cust_cc_exp: '10/20', cust_addr: 'Fantasy Land', id: 10, created_at: Time.now, updated_at: Time.now },
  { cust_name: 'Ialways Wearmask', status: 'completed', cust_email: 'standingoveryouwiththatcreepymask@yourhouse.com', cust_cc: '1234567890', cust_cc_exp: '10/20', cust_addr: 'Charbroiled Goodness St', id: 11, created_at: Time.now, updated_at: Time.now },
  { cust_name: 'Hermit Wizard', status: 'completed', cust_email: 'lookingforlove@lonelyville.com', cust_cc: '1234567890', cust_cc_exp: '10/20', cust_addr: 'The cave', id: 12, created_at: Time.now, updated_at: Time.now }
  ])

categories = Category.create([
  {name: 'Magic Ingredients', id: 1},
  {name: 'Legendary Items', id: 2},
  {name: 'Mythical Creatures', id: 3},
  {name: 'Enchanted Food', id: 4},
  {name: 'Apparel', id: 5},
  {name: 'Curses', id: 6}
  ])

products = Product.create([
  { name: 'Peaches of Immortality ', image_url: 'http://4.bp.blogspot.com/-5GQ1fBLNVr4/UAM6EnUpUSI/AAAAAAAAEyg/XKNYdq4P8x4/s1600/6a00e55119b5ec8834012877293a88970c-800wi.jpg', price: 3.25, quantity: 120, description: "Magical powers of immortality given from one bite", id: 1, created_at: Time.now, updated_at: Time.now, merchant_id: 4  },
  { name: 'That Ring', image_url: 'https://listverse.com/wp-content/uploads/2013/08/the-one-ring-e1375311691730.jpg', price: 350.00, quantity: 1, description: "The ring that gives you invisibility", id: 2, created_at: Time.now, updated_at: Time.now, merchant_id: 4  },
  {name: 'Dragon\'s Tooth', image_url: 'https://img1.etsystatic.com/100/0/9170080/il_340x270.831176717_5zaz.jpg', price: 9.99, quantity: 4, description: "Gives magical powers to it's owner.", id: 3, created_at: Time.now, updated_at: Time.now, merchant_id: 4  },
  { name: 'Helm of Darkness', image_url: 'http://cdn3.list25.com/wp-content/uploads/2017/04/HELMOFDARKNESSorsimilarmaybesubstituted-610x610.jpg', price: 49.99, quantity: 25, description: "Turn into a shadow with this magical helmet.", id: 4, created_at: Time.now, updated_at: Time.now , merchant_id: 5 },
  {  name: 'Umbra Staff', image_url: 'https://image.freepik.com/free-photo/umbrella-closed_19-121570.jpg', price: 693.39, quantity: 10, description: "This is a supremely powerful magic wand, imbued with the soul of a great wizard. It's definitely not just an umbrella.", id: 5, created_at: Time.now, updated_at: Time.now, merchant_id: 6  },
  {  name: 'My Little Pony (REAL)', image_url: 'https://lilyladewig.files.wordpress.com/2009/04/glitter-pony-2.jpg', price: 123.45, quantity: 100, description: "REAL PONY REAL MAGIC!! NOT FAKE", id: 6, created_at: Time.now, updated_at: Time.now, merchant_id: 7  },
  {  name: 'Witch\'s Tears', image_url: 'https://i.ebayimg.com/images/g/BlsAAOSwWnFV84vC/s-l300.jpg', price: 21.21, quantity: 50, description: "You have to be really mean to a witch to make these.", id: 7, created_at: Time.now, updated_at: Time.now, merchant_id: 8  },
  {name: 'Golden Fleece', image_url: 'https://i.imgur.com/UMHsPJn.jpg', price: 5000.39 , quantity: 1, description: "Fresh Golden Fleece.", id: 8, created_at: Time.now, updated_at: Time.now, merchant_id: 7   },
  { name: 'Excalibur', image_url: 'https://i.imgur.com/2cGiWjQ.jpg', price: 50.01, quantity: 1, description: "Do you want to be the King of Camelot?  Here is your chance.  Also, people used to be a lot smaller than they are now.", id: 9, created_at: Time.now, updated_at: Time.now, merchant_id: 6 },
  { name: 'Ghost of Caesar in a Mason Jar', image_url: 'https://i.imgur.com/ys1of8Rr.jpg', price: 2145.96, quantity: 1, description: "There are so many uses for this ghost in a jar.  Are you interested in learning Latin?  Have someone you really need to scare?  This ghost will haunt like none other.  Just open the jar and your home, work, or back yard is haunted by Julius Caesar.  You'll be saying 'E Tu, Brute' in no time.", id: 10, created_at: Time.now, updated_at: Time.now, merchant_id: 4  },
  { id: 11, name: 'Monkey\'s  Paw', image_url: 'https://theluckycandle.com/wp-content/uploads/2014/07/Monkey-Paw-.jpg', price: 777.00, quantity: 60, description: 'The paw of a monkey, said to grant any wish in unfathomable ways.(Seller does not take any responsibility for the outcome of said wishes)', created_at: Time.now, updated_at: Time.now, merchant_id: 3 },
  { id: 12, name: 'Bloodied Parchments of Merlin', image_url: 'https://orig00.deviantart.net/e72e/f/2011/259/a/1/bloody_parchment_by_shinjite_samachan-d4a2dlf.jpg', price: 20, quantity: 300, description: 'Parchments said to come from the infamous wizard himself. Papers are bloodied to the point of illegibility.', created_at: Time.now, updated_at: Time.now, merchant_id: 4 },
  { id: 13, name: 'Golden Saddles of Mercury', image_url: 'https://i.pinimg.com/736x/3a/b2/b6/3ab2b6bc38cc66bbdad7c4cca2b02812.jpg', price: 104.67, quantity: 9, description: 'Sturdy leather saddle set for horse-riding enthusiasts. Recommended for winged steeds.', created_at: Time.now, updated_at: Time.now, merchant_id: 5 },
  { id: 14, name: 'Mermaid Fin', image_url: 'https://www.finfunmermaid.com/images/products/dragonfly-mermaid-tail_category.jpg', price: 35.00, quantity: 2017, description: 'Fins collected from mermaids who decided to give up their underwater life to be where the (land) people are.', created_at: Time.now, updated_at: Time.now, merchant_id: 6 }
  ])

p = Product.find(1); p.categories << [Category.find(4), Category.find(1)]; p.save
p = Product.find(2); p.categories << Category.find(2); p.save
p = Product.find(3); p.categories << Category.find(1); p.save
p = Product.find(4); p.categories << Category.find(5); p.save
p = Product.find(5); p.categories << [Category.find(2), Category.find(4)]; p.save
p = Product.find(6); p.categories << Category.find(3); p.save
p = Product.find(7); p.categories << Category.find(1); p.save
p = Product.find(8); p.categories << Category.find(1); p.save
p = Product.find(9); p.categories << Category.find(2); p.save
p = Product.find(10); p.categories << Category.find(6); p.save
p = Product.find(11); p.categories << [Category.find(6), Category.find(1), Category.find(2)]; p.save
p = Product.find(12); p.categories << Category.find(1); p.save
p = Product.find(13); p.categories << Category.find(2); p.save
p = Product.find(14); p.categories << Category.find(3); p.save

order_products = OrderProduct.create([
  { status: 'shipped', quantity: '1', order_id: 1, product_id: 13, created_at: Time.now, updated_at: Time.now, id: 1 },
  { status: 'shipped', quantity: '3', order_id: 2, product_id: 12, created_at: Time.now, updated_at: Time.now, id: 2 },
  { status: 'shipped', quantity: '1', order_id: 3, product_id: 11, created_at: Time.now, updated_at: Time.now, id: 3 },
  { status: 'shipped', quantity: '3', order_id: 4, product_id: 10, created_at: Time.now, updated_at: Time.now, id: 4 },
  { status: 'shipped', quantity: '1', order_id: 5, product_id: 8, created_at: Time.now, updated_at: Time.now, id: 5 },
  { status: 'shipped', quantity: '3', order_id: 6, product_id: 7, created_at: Time.now, updated_at: Time.now, id: 6 },
  { status: 'shipped', quantity: '1', order_id: 7, product_id: 9, created_at: Time.now, updated_at: Time.now, id: 7 },
  { status: 'shipped', quantity: '3', order_id: 8, product_id: 1, created_at: Time.now, updated_at: Time.now, id: 8 },
  { status: 'shipped', quantity: '1', order_id: 9, product_id: 2, created_at: Time.now, updated_at: Time.now, id: 9 },
  { status: 'shipped', quantity: '3', order_id: 10, product_id: 3, created_at: Time.now, updated_at: Time.now, id: 10 },
  { status: 'shipped', quantity: '1', order_id: 11, product_id: 4, created_at: Time.now, updated_at: Time.now, id: 11 },
  { status: 'shipped', quantity: '3', order_id: 12, product_id: 5, created_at: Time.now, updated_at: Time.now, id: 12 },
  { status: 'shipped', quantity: '1', order_id: 11, product_id: 6, created_at: Time.now, updated_at: Time.now, id: 13 },
  { status: 'shipped', quantity: '3', order_id: 10, product_id: 7, created_at: Time.now, updated_at: Time.now, id: 14 },
  { status: 'shipped', quantity: '1', order_id: 9, product_id: 8, created_at: Time.now, updated_at: Time.now, id: 15 },
  { status: 'shipped', quantity: '3', order_id: 8, product_id: 9, created_at: Time.now, updated_at: Time.now, id: 16 },
  { status: 'shipped', quantity: '1', order_id: 7, product_id: 14, created_at: Time.now, updated_at: Time.now, id: 17 }
  ])

reviews = Review.create([
  { rating: 5, description: 'very nice and magic', product_id: 6, created_at: Time.now, updated_at: Time.now, id: 1 },
  { rating: 1, description: 'these are wizards tears, NOT witch\'s tears. seller should be ashamed', product_id: 7, created_at: Time.now, updated_at: Time.now, id: 2 }
  ])

puts "Manually resetting PK sequence on each table"
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end
