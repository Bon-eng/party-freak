require 'rails_helper'

describe UsersController, type: :request do

  before do
    @user = FactoryBot.build(:user)
    @party = FactoryBot.build(:party)
    @review = FactoryBot.build(:review)
  end

  describe "GET #index" do
    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do
      get user_path(@user.id)
      binding.pry
      expect(response.status).to eq 200
    end
    # it "indexアクションにリクエストするとレスポンスに投稿済みのpartyの名前が存在する" do
    #   get root_path
    #   expect(response.body).to include(@review.title)
    #   expect(response.body).to include (@party)
    #   expect(assigns(:party)).to eq party
    # end
  end
  # describe "GET #show" do
  #   it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do
  #     get root_path
  #     expect(response.status).to eq 200
  #   end

  # end
end