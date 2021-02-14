require 'rails_helper'

describe PartiesController, type: :request do

  before do
    @party = FactoryBot.build(:party)
    @review = FactoryBot.build(:review)
  end

  describe "GET #index" do
    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do
      get root_path
      expect(response.status).to eq 200
    end

    it "@partyが期待される値を持つ" do
      party = create(:party)
      get :index, party_id: party
      expect(assigns(:party)).to eq party
    end

    it "indexアクションにリクエストするとレスポンスに投稿済みのpartyの名前が存在する" do
      # get root_path
      # binding.pry
      # expect(response.body).to include (@party.name)
      # expect(assigns(:party)).to eq party
    end
    it "indexアクションにリクエストするとレスポンスに投稿済みのpartyの画像が存在する" do
      # get root_path
      # binding.pry
      # expect(response.body).to include(@party.image)
    end
    it "indexアクションにリクエストするとレスポンスに投稿済みのpartyの開催地域が存在する" do
      # get root_path
      # binding.pry
      # expect(response.body).to include(@party.country_id)
    end
    it "indexアクションにリクエストするとレスポンスに投稿済みのpartyのジャンルが存在する" do
    end
    it "indexアクションにリクエストするとレスポンスに投稿済みのreviewのタイトルが存在する" do
      # get root_path
      # binding.pry
      # expect(response.body).to include (@review.title)
    end
    # it "indexアクションにリクエストするとレスポンスに投稿済みのreviewの本文が存在する" do
    # end
    # it "indexアクションにリクエストするとレスポンスに投稿済みのreviewの画像が存在する" do
    # end
  end

  describe "GET #show" do
    it "showアクションにリクエストすると正常にレスポンスが返ってくる" do
      # @party = create(:party)
      # get :show, params: { id: @party.id }

    end
  end
end