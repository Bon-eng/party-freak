require 'rails_helper'

describe PartiesController, type: :request do

  before do
    @party = FactoryBot.build(:party)
  end

  describe "GET #index" do
    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do
      get root_path
      expect(response.status).to eq 200
    end
    it "indexアクションにリクエストするとレスポンスに投稿済みのpartyの名前が存在する" do
      get root_path
      binding.pry
      expect(response).to render_template :index
      # expect(response.body).to include (@party)
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
    # it "indexアクションにリクエストするとレスポンスに投稿済みのreviewのタイトルが存在する" do
    # end
    # it "indexアクションにリクエストするとレスポンスに投稿済みのreviewの本文が存在する" do
    # end
    # it "indexアクションにリクエストするとレスポンスに投稿済みのreviewの画像が存在する" do
    # end
  end
end