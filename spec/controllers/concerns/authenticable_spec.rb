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

end