require_relative 'active_store/base_model'

class User < ActiveStore::BaseModel
  attributes id: Integer, name: String, age: Integer
end

class Product < ActiveStore::BaseModel
  attributes id: Integer, title: String, user: User
end

user1 = User.create(id: 1, name: "Alice", age: 30)
user2 = User.create(id: 2, name: "Bob", age: 25)

product = Product.create(id: 1, title: "tovar", user: user1)

# Read
users = User.all
puts users.inspect

# Find
user = User.find_by(name: "Alice")
puts user.inspect

# Update
User.update(1, name: "Alicia", age: 31)

# Delete
User.delete(2)

# Clear
User.clear_store

