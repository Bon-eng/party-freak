require 'rails_helper'
RSpec.describe UsersController, type: :request do
  before do
    @user = FactoryBot.create(:user)
  end
#全15項目
  describe 'GET /sessions#new' do
    it 'ログインページにリクエストすると正常にレスポンスが返ってくる' do
      get new_user_session_path
      expect(response.status).to eq 200
    end
  end

  describe 'POST /sessions#create' do
    it 'ログインページにリクエストすると正常にレスポンスが返ってくる' do
      post user_session_path
      expect(response.status).to eq 200
    end
  end

  describe 'DELETE /sessions#destroy' do
    it 'ログアウトページにリクエストすると正常にレスポンスが返ってくる' do
      delete destroy_user_session_path
      expect(response.status).to eq 302
    end
  end

  describe 'POST /sessions#new_guest' do
    it 'ゲストログインページにリクエストすると正常にレスポンスが返ってくる' do
      post users_guest_sign_in_path
      expect(response.status).to eq 302
    end
  end

  describe 'GET #show' do
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do
      get user_path(@user)
      expect(response.status).to eq 200
    end
    it "showアクションにリクエストするとレスポンスに登録済みuserの名前が存在する" do 
      get user_path(@user)
      expect(response.body).to include @user.nickname
    end
    it "showアクションにリクエストするとレスポンスに登録済みuserの性別が存在する" do 
      get user_path(@user)
      expect(response.body).to include @user.gender.name
    end
    it "showアクションにリクエストするとレスポンスに登録済みuserの好きなジャンルが存在する" do 
      get user_path(@user)
      expect(response.body).to include @user.genre.name
    end
    it "showアクションにリクエストするとレスポンスに登録済みuserのプロフィールが存在する" do 
      get user_path(@user)
      expect(response.body).to include @user.profile
    end
  end

  describe 'GET #edit' do
    context 'userがログインしているとき' do
      before do
        sign_in @user
      end
      it 'editアクションにリクエストすると正常にレスポンスが返ってくる' do
        get edit_user_path(@user)
        expect(response.status).to eq 200
      end
      it "editアクションにリクエストするとレスポンスに登録済みuserの名前が存在する" do 
        get edit_user_path(@user)
        expect(response.body).to include @user.nickname
      end
      it "editアクションにリクエストするとレスポンスに登録済みuserの性別が存在する" do 
        get edit_user_path(@user)
        expect(response.body).to include @user.gender.name
      end
      it "editアクションにリクエストするとレスポンスに登録済みuserの好きなジャンルが存在する" do 
        get edit_user_path(@user)
        expect(response.body).to include @user.genre.name
      end
      it "editアクションにリクエストするとレスポンスに登録済みuserのプロフィールが存在する" do 
        get edit_user_path(@user)
        expect(response.body).to include @user.profile
      end
    end

    context 'userがログインしていないとき' do
      it 'editアクションにリクエストすると正常にレスポンスが返ってくる' do
        get edit_user_path(@user)
        expect(response.status).to eq 302
      end
    end
  end
end
