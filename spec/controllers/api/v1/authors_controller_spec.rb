require 'spec_helper'

describe Api::V1::AuthorsController do
  before(:each) { request.headers['Accept'] = "application/vnd.recipe_api.v1" }

  describe "GET #show" do
    before(:each) do
      @author = FactoryGirl.create :author
      get :show, id: @author.id, format: :json
    end

    it "returns the information about a reporter on a hash" do
      author_response = JSON.parse(response.body, symbolize_names: true)
      expect(author_response[:email]).to eql @author.email
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do

    context "when is successfully created" do
      before(:each) do
        @author_attributes = FactoryGirl.attributes_for :author
        post :create, { author: @author_attributes }, format: :json
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
        post :create, { author: @invalid_author_attributes }, format: :json
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

end
