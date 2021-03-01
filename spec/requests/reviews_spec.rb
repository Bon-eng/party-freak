require 'rails_helper'

RSpec.describe ReviewsController, type: :request do
  let(:admin_user) { FactoryBot.create(:user, admin: true) }
  let(:party) { FactoryBot.create(:party, user_id: user.id) }
  let(:user) { FactoryBot.create(:user) }
  before do
    @user = FactoryBot.create(:user)
    @party = FactoryBot.create(:party)
    @review = FactoryBot.create(:review)
  end

  # describe 'POST #create' do
  #   it 'createアクションにリクエストすると正常にレスポンスが返ってくる' do
  #     post party_reviews_path(@party, @review.party), params: { id: @party_id, review: FactoryBot.attributes_for(:review) }
  #     expect(response.status).to eq 200
  #   end
  # end

  describe 'GET #edit' do
    it 'editアクションにリクエストすると正常にレスポンスが返ってくる' do
      get edit_party_review_path(@party, @review.party)
      expect(response.status).to eq 302
    end
  end

  describe 'DELETE #destroy' do
    it 'destroyアクションにリクエストすると正常にレスポンスが返ってくる' do
      delete party_review_path(@party, @review.party)
      expect(response.status).to eq 302
    end
  end

  # describe 'GET #show' do
  #   it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do
  #     get party_review_path(@party, @review.party)
  #     expect(response.status).to eq 200
  #   end
  #   it "showアクションにリクエストするとレスポンスに投稿済みpartyの画像が存在する" do 
  #     get party_review_path(@party, @review.party)
  #     expect(response.body).to include 'test_image.jpg'
  #   end
  #   it "showアクションにリクエストするとレスポンスに投稿済みpartyの名前が存在する" do 
  #     get party_review_path(@party, @review.party)
  #     expect(response.body).to include @party.name
  #   end
  #   it "showアクションにリクエストするとレスポンスに投稿済みpartyの紹介文が存在する" do 
  #     get party_review_path(@party, @review.party)
  #     expect(response.body).to include @party.introduction
  #   end
  #   it "showアクションにリクエストするとレスポンスに投稿済みpartyの開催時期が存在する" do 
  #     get party_review_path(@party, @review.party)
  #     expect(response.body).to include @party.season.name
  #   end
  #   it "showアクションにリクエストするとレスポンスに投稿済みpartyの開催地域が存在する" do 
  #     get party_review_path(@party, @review.party)
  #     expect(response.body).to include @party.country.name
  #   end
  #   it "showアクションにリクエストするとレスポンスに投稿済みpartyのジャンルが存在する" do 
  #     get party_review_path(@party, @review.party)
  #     expect(response.body).to include @party.genre.name
  #   end
  #   it "showアクションにリクエストするとレスポンスに投稿済みpartyのオフィシャルHPが存在する" do 
  #     get party_review_path(@party, @review.party)
  #     expect(response.body).to include @party.official_url
  #   end
  # end

  #   describe 'PUT #update' do
  #   it 'updateアクションにリクエストすると正常にレスポンスが返ってくる' do
  #     put party_review_path(@party, @review.party), params: { id: @party_id, review: FactoryBot.attributes_for(:review) }
  #     expect(response.status).to eq 200
  #   end
  # end

end
