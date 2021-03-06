require 'rails_helper'
RSpec.describe ReviewsController, type: :request do
  before do
    @user = FactoryBot.create(:user)
    @party = FactoryBot.create(:party, user_id: @user.id)
    @review = FactoryBot.create(:review, party_id: @party.id, user_id: @user.id)
  end
#全7項目

  describe 'POST #create' do
    it 'createアクションにリクエストすると正常にレスポンスが返ってくる' do
      sign_in @user
      post party_reviews_path(@party.id, @review.id), params: { id: @party_id, review: FactoryBot.attributes_for(:review) }
      expect(response.status).to eq 200
    end
  end

  describe 'GET #edit' do
    context 'ログインしているとき' do
      before do
        sign_in @user
      end
      it 'editアクションにリクエストすると正常にレスポンスが返ってくる' do
        get edit_party_review_path(@party.id, @review.id)
        expect(response.status).to eq 200
      end
      it "editアクションにリクエストするとレスポンスに投稿済みレビュータイトルが存在する" do 
        get edit_party_review_path(@party.id, @review.id)
        expect(response.body).to include @review.title
      end
      it "editアクションにリクエストするとレスポンスに投稿済みレビュー本文が存在する" do 
        get edit_party_review_path(@party.id, @review.id)
        expect(response.body).to include @review.content
      end
    end
    context 'ログインしていないとき' do
      it 'editアクションにリクエストすると正常にレスポンスが返ってくる' do
        get edit_party_review_path(@party.id, @review.id)
        expect(response.status).to eq 302
      end
    end
  end

  describe 'PUT #update' do
    it 'updateアクションにリクエストすると正常にレスポンスが返ってくる' do
      sign_in @user
      put party_review_path(@party.id, @review.id), params: { id: @party_id, review: FactoryBot.attributes_for(:review) }
      expect(response.status).to eq 302
    end
  end

  describe 'DELETE #destroy' do
    it 'destroyアクションにリクエストすると正常にレスポンスが返ってくる' do
      delete party_review_path(@party.id, @review.id)
      expect(response.status).to eq 302
    end
  end
end
