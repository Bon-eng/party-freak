require 'rails_helper'
RSpec.describe PartiesController, type: :request do
  before do
    @user = FactoryBot.create(:user)
    @admin_user = FactoryBot.create(:user, admin: true)
    @party = FactoryBot.create(:party)
  end
#全24項目

    describe 'GET #index' do
      it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
        get root_path
        expect(response.status).to eq 200
      end
    end

    describe 'GET #new' do
      context 'admin_userがログインしているとき' do
        it 'newアクションにリクエストすると正常にレスポンスが返ってくる' do
          sign_in @admin_user
          get new_party_path
          expect(response.status).to eq 200
        end
      end
      context 'ログインしていないとき' do
        it 'newアクションにリクエストすると正常にレスポンスが返ってくる' do
          get new_party_path
          expect(response.status).to eq 302
        end
      end
    end

    describe 'POST #create' do
      it 'createアクションにリクエストすると正常にレスポンスが返ってくる' do
        sign_in @admin_user
        post parties_path, params: { id: @user_id, party: FactoryBot.attributes_for(:party) }
        expect(response.status).to eq 200
      end
    end

    describe 'GET #show' do
      it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do
        get party_path(@party)
        expect(response.status).to eq 200
      end
      it "showアクションにリクエストするとレスポンスに投稿済みpartyの画像が存在する" do 
        get party_path(@party)
        expect(response.body).to include 'test_image.jpg'
      end
      it "showアクションにリクエストするとレスポンスに投稿済みpartyの名前が存在する" do 
        get party_path(@party)
        expect(response.body).to include @party.name
      end
      it "showアクションにリクエストするとレスポンスに投稿済みpartyの紹介文が存在する" do 
        get party_path(@party)
        expect(response.body).to include @party.introduction
      end
      it "showアクションにリクエストするとレスポンスに投稿済みpartyの開催時期が存在する" do 
        get party_path(@party)
        expect(response.body).to include @party.season.name
      end
      it "showアクションにリクエストするとレスポンスに投稿済みpartyの開催地域が存在する" do 
        get party_path(@party)
        expect(response.body).to include @party.country.name
      end
      it "showアクションにリクエストするとレスポンスに投稿済みpartyのジャンルが存在する" do 
        get party_path(@party)
        expect(response.body).to include @party.genre.name
      end
      it "showアクションにリクエストするとレスポンスに投稿済みpartyのオフィシャルHPが存在する" do 
        get party_path(@party)
        expect(response.body).to include @party.official_url
      end
    end

    describe 'GET #edit' do
      context '@admin_userがログインしているとき' do
        before do
          sign_in @admin_user
        end
        it 'editアクションにリクエストすると正常にレスポンスが返ってくる' do
          get edit_party_path(@party)
          expect(response.status).to eq 200
        end
        it "editアクションにリクエストするとレスポンスに投稿済みpartyの名前が存在する" do 
          get edit_party_path(@party)
          expect(response.body).to include @party.name
        end
        it "editアクションにリクエストするとレスポンスに投稿済みpartyの紹介文が存在する" do 
          get edit_party_path(@party)
          expect(response.body).to include @party.introduction
        end
        it "editアクションにリクエストするとレスポンスに投稿済みpartyの開催時期が存在する" do 
          get edit_party_path(@party)
          expect(response.body).to include @party.season.name
        end
        it "editアクションにリクエストするとレスポンスに投稿済みpartyの開催地域が存在する" do 
          get edit_party_path(@party)
          expect(response.body).to include @party.country.name
        end
        it "editアクションにリクエストするとレスポンスに投稿済みpartyのジャンルが存在する" do 
          get edit_party_path(@party)
          expect(response.body).to include @party.genre.name
        end
        it "editアクションにリクエストするとレスポンスに投稿済みpartyのオフィシャルHPが存在する" do 
          get edit_party_path(@party)
          expect(response.body).to include @party.official_url
        end
      end
      context 'ログインしていないとき' do
        it 'editアクションにリクエストすると正常にレスポンスが返ってくる' do
          get edit_party_path(@party)
          expect(response.status).to eq 302
        end
      end
    end

    describe 'PUT #update' do
      it 'updateアクションにリクエストすると正常にレスポンスが返ってくる' do
        sign_in @admin_user
        patch party_path(@party), params: { id: @user_id, party: FactoryBot.attributes_for(:party) }
        expect(response.status).to eq 302
      end
    end

    describe 'DELETE #destroy' do
      it 'destroyアクションにリクエストすると正常にレスポンスが返ってくる' do
        delete party_path(@party)
        expect(response.status).to eq 302
      end
    end

    describe 'GET #lineup' do
      it 'lineupアクションにリクエストすると正常にレスポンスが返ってくる' do
        get lineup_parties_path(@party)
        expect(response.status).to eq 200
      end
    end

    describe 'GET #search' do
      it 'searchアクションにリクエストすると正常にレスポンスが返ってくる' do
        get search_parties_path(@party)
        expect(response.status).to eq 200
      end
    end
end
