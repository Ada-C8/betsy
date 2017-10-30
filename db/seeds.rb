# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

#---------------------------------------------------
CATEGORY_FILE = Rails.root.join('db', 'seed_data', 'categories.csv')
puts "Loading raw work data from #{CATEGORY_FILE}"

category_failures = []
CSV.foreach(CATEGORY_FILE, :headers => true) do |row|
  category = Category.new
  category.id = row['id']
  category.name = row['name']

  puts "Created work: #{category.inspect}"
  successful = category.save
  if !successful
    category_failures << category
    puts category.errors
    puts "----------"
    category.errors.each do |column, message|
      puts "#{column}: #{message}"
    end
    puts "----------"
  end

end

puts "Added #{Category.count} category records"
puts "#{category_failures.length} category failed to save"


# Since we set the primary key (the ID) manually on each of the
# tables, we've got to tell postgres to reload the latest ID
# values. Otherwise when we create a new record it will try
# to start at ID 1, which will be a conflict.
puts "Manually resetting PK sequence on each table"
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

puts "done"


#---------------------------------------------------
USER_FILE = Rails.root.join('db', 'seed_data', 'users.csv')
puts "Loading raw work data from #{USER_FILE}"

user_failures = []
CSV.foreach(USER_FILE, :headers => true) do |row|
  user = User.new
  user.id = row['id']
  user.name = row['name']
  user.email = row['email']
  user.merchant_status = row['merchant_status']
  user.uid = row['uid']
  user.provider = row['provider']
  puts "Created work: #{user.inspect}"
  successful = user.save
  if !successful
    user_failures << user
    puts user.errors
    puts "----------"
    user.errors.each do |column, message|
      puts "#{column}: #{message}"
    end
    puts "----------"
  end

end

puts "Added #{User.count} user records"
puts "#{user_failures.length} user failed to save"


# Since we set the primary key (the ID) manually on each of the
# tables, we've got to tell postgres to reload the latest ID
# values. Otherwise when we create a new record it will try
# to start at ID 1, which will be a conflict.
puts "Manually resetting PK sequence on each table"
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

puts "done"


#---------------------------------------------------
PRODUCT_FILE = Rails.root.join('db', 'seed_data', 'product_seeds.csv')
puts "Loading raw work data from #{PRODUCT_FILE}"


i = 1000
product_failures = []
CSV.foreach(PRODUCT_FILE, :headers => true) do |row|
  product = Product.new
  product.id = i
  product.user_id = row['user_id']
  product.category = row['category']
  product.name = row['name']
  product.price = row['price']
  product.quantity = row['quantity']
  product.description = row['description']
  product.stock = row['stock']

  puts "Created work: #{product.inspect}"
  successful = product.save
  product.categories << Category.find_by(name: product.category)

  if !successful
    product_failures << product
    puts product.errors
    puts "----------"
    product.errors.each do |column, message|
      puts "#{column}: #{message}"
    end
    puts "----------"
  end

  i += 1
end

puts "Added #{Product.count} product records"
puts "#{product_failures.length} products failed to save"


# Since we set the primary key (the ID) manually on each of the
# tables, we've got to tell postgres to reload the latest ID
# values. Otherwise when we create a new record it will try
# to start at ID 1, which will be a conflict.
puts "Manually resetting PK sequence on each table"
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

puts "done"
