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
end
