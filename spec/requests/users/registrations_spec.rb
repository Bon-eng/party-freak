require 'rails_helper'

RSpec.describe "Users::Registrations", type: :request do
  let(:user) { FactoryBot.create(:user) }
  before do
    @user = FactoryBot.create(:user)
  end

  describe 'POST /users/registrations/create' do
    context 'パラメータが正常な場合' do
      it '新規登録ページにリクエストすると正常にレスポンスが返ってくる' do
        post user_registration_path
        expect(response.status).to eq 200
      end
      it 'ユーザーが新規登録される' do
        expect do
          post user_registration_path, params: { user: FactoryBot.attributes_for(:user) }
        end.to change { User.count }.by(1)
      end
      it '新規登録が完了したらトップページにリダイレクトする' do
        post user_registration_path, params: { user: FactoryBot.attributes_for(:user) }
        expect(response).to redirect_to root_path
      end
    end
    context 'パラメータが異常な場合' do
      it '新規登録ページにリクエストすると正常にレスポンスが返ってくる' do
        post user_registration_path
        expect(response.status).to eq 200
      end
      it 'ユーザーが新規登録できない' do
        expect do
          post user_registration_path
        end.to change { User.count }.by(0)
      end
    end
  end

  describe 'PUT /users/registrations/update' do
    it 'updateアクションにリクエストすると正常にレスポンスが返ってくる' do
      put user_registration_path, params: { id: @user_id, user: FactoryBot.attributes_for(:user) }
      expect(response.status).to eq 302
    end
  end

end
