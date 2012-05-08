# UserSettingsModel

UserSettingsModel use NSUserSettings to store model data. 

This is designed to store small amount of data, and when performance is not an issue.

## Define Model

Define your class as you would normally do. Include the Model module.

Use attribute method to define attributes.

````ruby
class User
  include Model

  attribute :name
  attribute :age
end
````

## Using Model


### Create

Use save method to store your model

````ruby
user = User.new
user.name = "Bob"
user.age = 18
user.save
````

### Retrieve

Use all method to find all models

````ruby
User.all => [<User#1>, <User#2> ...]
````

Use get method to get a model by id

````ruby
User.get(1) => <User#1>
```

### Update

Save an existing model to update it

````ruby
user = User.get(1)
user.name = "Thomas"
user.save
````

### Delete

Use delete method to delete

````ruby
user = User.get(1)
user.delete
````
