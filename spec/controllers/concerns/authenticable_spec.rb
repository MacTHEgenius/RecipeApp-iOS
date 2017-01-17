require 'spec_helper'

class Authentication
  include Authenticable
end

describe Authenticable do

  let(:authentication) { Authentication.new }
  subject { authentication }

  describe '#current_author' do
    before do
      @author = FactoryGirl.create :author
      request.headers["Authorization"] = @author.auth_token
      authentication.stub(:request).and_return(request)
    end

    it "returns the author from the authorization header" do
      expect(authentication.current_author.auth_token).to eql @author.auth_token
    end
  end

  describe "#authenticate_with_token" do
    before do
      @author = FactoryGirl.create :author
      authentication.stub(:current_author).and_return(nil)
      response.stub(:response_code).and_return(401)
      response.stub(:body).and_return({:errors => "Not authenticated"}.to_json)
      authentication.stub(:response).and_return(response)
    end

    it "render a json error message" do
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response[:errors]).to eql "Not authenticated"
    end

    it { should respond_with 401 }
  end

end