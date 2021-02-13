require 'rails_helper'

describe UsersController, type: :request do

  before do
    @user = FactoryBot.build(:user)
    @review = FactoryBot.build(:review)
  end

  describe "GET #index" do
    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do
      get root_path
      expect(response.status).to eq 200
    end
    it "indexアクションにリクエストするとレスポンスに投稿済みのpartyの名前が存在する" do
      get root_path
      binding.pry
      expect(response.body).to include(@review.title)
      # expect(response.body).to include (@party)
      # expect(assigns(:party)).to eq party
    end

  end
end