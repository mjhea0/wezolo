require 'spec_helper'

describe MessagesController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      pending
      # get 'create'
      # response.should be_success
    end
  end

end
