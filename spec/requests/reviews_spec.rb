require 'rails_helper'

describe UsersController, type: :request do

  before do
    @user = FactoryBot.build(:user)
    @party = FactoryBot.build(:party)
    @review = FactoryBot.build(:review)
  end

  describe "GET #index" do
    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do
      binding.pry
      get party_reviews_path(:party_id)
      expect(response.status).to eq 200
    end

  end
end
