require 'spec_helper'

describe Api::V1::AuthorsController do
  before(:each) do
    request.headers['Accept'] = "application/vnd.recipe_api.v1, #{Mime::JSON}"
    request.headers['Content-Type'] = Mime::JSON.to_s
  end

  describe "GET #show" do
    before(:each) do
      @author = FactoryGirl.create :author
      get :show, id: @author.id
    end

    it "returns the information about a reporter on a hash" do
      author_response = JSON.parse(response.body, symbolize_names: true) # Replace each with json_response
      expect(author_response[:email]).to eql @author.email
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do

    context "when is successfully created" do
      before(:each) do
        @author_attributes = FactoryGirl.attributes_for :author
        post :create, { author: @author_attributes }
      end

      it "renders the json representation for the author record just created" do
        author_response = JSON.parse(response.body, symbolize_names: true)
        expect(author_response[:email]).to eql @author_attributes[:email]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        # no email
        @invalid_author_attributes = { password: "12345678",
                                     password_confirmation: "12345678" }
        post :create, { author: @invalid_author_attributes }
      end

      it "renders an errors json" do
        author_response = JSON.parse(response.body, symbolize_names: true)
        expect(author_response).to have_key(:errors)
      end

      it "renders the json errors on why the author could not be created" do
        author_response = JSON.parse(response.body, symbolize_names: true)
        expect(author_response[:errors][:email]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do

    context "when is successfully updated" do
      before(:each) do
        @author = FactoryGirl.create :author
        patch :update, { id: @author.id,
                         author: { email: "newmail@example.com" } }
      end

      it "renders the json representation for the updated author" do
        author_response = JSON.parse(response.body, symbolize_names: true)
        expect(author_response[:email]).to eql "newmail@example.com"
      end

      it { should respond_with 200 }
    end

    context "when is not created" do
      before(:each) do
        @author = FactoryGirl.create :author
        patch :update, { id: @author.id,
                         author: { email: "bademail.com" } }
      end

      it "renders an errors json" do
        author_response = JSON.parse(response.body, symbolize_names: true)
        expect(author_response).to have_key(:errors)
      end

      it "renders the json errors on why the author could not be created" do
        author_response = JSON.parse(response.body, symbolize_names: true)
        expect(author_response[:errors][:email]).to include "is invalid"
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @author = FactoryGirl.create :author
      delete :destroy, { id: @author.id }
    end

    it { should respond_with 204 }

  end

end
