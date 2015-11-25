require 'authenticate'
require 'rails_helper'

describe Authenticate do
  let(:valid_token) { ApiKey.create!.access_token}
  let(:invalid_token) { "invalid_token" }
  let(:empty_token) { "" }

  it "accepts a valid token" do
    expect(Authenticate.valid?(valid_token)).to be true
  end

  it "rejects an invalid token" do
    expect(Authenticate.valid?(invalid_token)).to be false
  end

  it "rejects an empty token" do
    expect(Authenticate.valid?(invalid_token)).to be false
  end
end
