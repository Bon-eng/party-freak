require 'rails_helper'
RSpec.describe PartiesController, type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:admin_user) { FactoryBot.create(:user, admin: true) }
  before do
    @party = FactoryBot.create(:party)
  end

    describe 'GET #index' do
      it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
        get root_path
        expect(response.status).to eq 200
      end
    end

    describe 'GET #new' do
      it 'newアクションにリクエストすると正常にレスポンスが返ってくる' do
        get new_party_path
        expect(response.status).to eq 200
      end
    end

    # describe 'POST #create' do
    #   it 'createアクションにリクエストすると正常にレスポンスが返ってくる' do
    #     post parties_path, params: { id: @user_id, party: FactoryBot.attributes_for(:party) }
    #     expect(response.status).to eq 302
    #   end
    # end

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

    # describe 'PUT #update' do
    #   it 'updateアクションにリクエストすると正常にレスポンスが返ってくる' do
    #     patch party_path(@party), params: { id: @user_id, party: FactoryBot.attributes_for(:party) }
    #     expect(response.status).to eq 200
    #   end
    # end

    describe 'DELETE #destroy' do
      it 'destroyアクションにリクエストすると正常にレスポンスが返ってくる' do
        delete party_path(@party)
        expect(response.status).to eq 302
      end
    end


end
