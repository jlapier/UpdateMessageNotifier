require 'spec_helper'

describe User do
  describe "when creating new users" do
    it "should create with proper attribs" do
      User.create! :email => "someone@example.com", :password => "testtest", :password_confirmation => "testtest"
    end

    it "should not create if password is not confirmed" do
      u = User.new :email => "someone@example.com", :password => "testtest", :password_confirmation => "testwrong"
      u.should_not be_valid
    end

    it "should not create without attrs" do
      u = User.new
      u.should_not be_valid
    end
  end
end
