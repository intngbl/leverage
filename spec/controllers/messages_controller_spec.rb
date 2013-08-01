require 'spec_helper'

describe MessagesController do
  let!(:rodowi) { FactoryGirl.create(:user, { name: "rodowi" }) }
  let!(:semana) { FactoryGirl.create(:agency, { name: "SEMANA" }) }
  let(:controller) { MessagesController.new }

  context "Create" do
    it "should parse recipients and find users" do
      found_users = controller.send(:find_users_by_recipients, "rodowi,SEMANA")
      found_users.should have(2).users
      expect(found_users).to include(rodowi, semana)
    end
  end

end
