require 'rails_helper'

describe User do
  context "when user is not valid" do
     it "check the user validation" do
       expect(User.new(password: "123")).not_to be_valid
     end
   end

end
