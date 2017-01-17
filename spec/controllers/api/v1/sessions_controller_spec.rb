require 'spec_helper'

describe Api::V1::SessionsController do

  describe 'POST #create' do

    before(:each) do
      @author = FactoryGirl.create :author
    end

    context "when the credentials are correct" do

      before(:each) do
        credentials = { email: @author.email, password: "12345678" }
        post :create, { session: credentials }
      end

      it "returns the author record corresponding to the given credentials" do
        @author.reload
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:auth_token]).to eql @author.auth_token
      end

      it { should respond_with 200 }
    end

    context "when the credentials are incorrect" do

      before(:each) do
        credentials = { email: @author.email, password: "invalidpassword" }
        post :create, { session: credentials }
      end

      it "returns a json with an error" do
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response[:errors]).to eql "Invalid email or password"
      end

      it { should respond_with 422 }
    end

  end

  describe "DELETE #destroy" do

    before(:each) do
      @author = FactoryGirl.create :author
      sign_in @author, store: false
      delete :destroy, id: @author.auth_token
    end

    it { should respond_with 204 }

  end

end
