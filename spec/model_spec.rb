describe Model do  
  class User
    include Model
    attribute :name
    attribute :age
  end

  before do
    User.clear
  end
  
  after do
  end

  it "should have key" do
    User.key.should == "model.User"
  end
  
  it "should have attributes" do
    User.attributes.should == [:name, :age]
  end
  
  it "should have settings" do
    User.settings.should == NSUserDefaults.standardUserDefaults
  end

  it "should have next_key" do
    User.next_key.should == 0
    User.next_key.should == 1
    User.next_key.should == 2
  end
  
  it "should have table" do
    User.table.class.should == Array
    User.table.should == []
  end
  
  it "should persist user" do
    user = User.new
    user.name = "Bob"
    user.age = 18
    user.save
    
    user2 = User.new
    user2.name = "Alice"
    user2.age = 20
    user2.save
  
    User.table.count.should == 2
    User.get(0).name.should == "Bob"
    User.get(0).age.should == 18
    User.get(0)._id.should == 0
    User.get(1).name.should == "Alice"
    User.get(1).age.should == 20
    User.get(1)._id.should == 1
    users = User.all
    users[0]._id.should == user._id
    users[1]._id.should == user2._id
  end

  # it "should delete user" do
  #   user = User.new
  #   user.name = "Bob"
  #   user.age = 18
  #   user.save
  #   
  #   User.table.count.should == 1
  #   User.destroy
  #   User.table.count.should == 0
  # 
  #   user2 = User.new
  #   user2.name = "Alice"
  #   user2.age = 20
  #   user2.save
  #   User.table.count.should == 1
  #   User.all.first._id.should == user2.id
  # end

  # it "should find user by criteria" do
  #   user = User.new
  #   user.name = "Bob"
  #   user.age = 18
  #   user.save
  #   
  #   user2 = User.new
  #   user2.name = "Alice"
  #   user2.age = 20
  #   user2.save
  #   
  #   user3 = User.new
  #   user3.name = "Carl"
  #   user3.age = 22
  #   user3.save
  # 
  #   User.all.count.should == 3
  #   results = User.all.select {|item| item.name == "Carl" }
  #   results.count.should == 1
  #   results.first._id.should == user3._id
  # end
    # 
    # it "should clear model" do
    #   user = User.new
    #   user.name = "Bob"
    #   user.age = 18
    #   user.save
    # 
    #   User.table.count.should == 1
    #   User.clear
    #   User.table.count.should == 0
    # end
  
end
