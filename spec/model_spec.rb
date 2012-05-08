describe Model do
  class User
    include Model
    attribute :name
    attribute :age
  end
  
  before do
    User.clear
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
    User.get(1).name.should == "Alice"
    User.get(1).age.should == 20
  end
end
