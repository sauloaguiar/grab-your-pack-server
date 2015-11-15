require 'rails_helper'

describe ApiConstraints do

  let(:api_constraints) { ApiConstraints.new }
  describe "matches?" do
    it "returns true when the header contains the api host address" do
      request = double(host: 'api.grabyourpack.dev', headers: {"Accept" => "application/vnd.grabyourpack"})
      expect(api_constraints.matches?(request)).to be true
    end
  end
end
