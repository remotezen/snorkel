require 'spec_helper'
describe RelationshipsController do 
  let(:user){ FactoryGirl.create(:user) }
  let(:other){ FactoryGirl.create(:user) }
  before { sign_in user, no_capybara: true }
  describe "createing a relationship with Ajax" do 
    it "should increment the Relationship count" do 
      expect do 
        xhr :post, :create, relationship: { followed_id: other.id }
      end.to change(Relationship, :count).by(1)
    end
    it "should respond with success" do 
      xhr :post, :create, relationship: { followed_id: other.id }
      expect(response).to be_success
    end
  end
  
  describe "destroying a relationship with ajax" do 
    before { user.follow!(other) }
    let(:relationship)  { user.relationships.find_by(followed_id: other ) }
    it "should decrement the Relationship count" do 
      expect do 
        xhr :delete, :destroy, id: realationship.id

      end.to change(Relationship, :count).by(-1)
    end
    it "should respond with success" do 
      xhr :delete, :destroy, id: relationship.id
      expect(response).to be_success
    end
  end
end

