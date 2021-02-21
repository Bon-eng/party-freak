require 'rails_helper'

describe UsersController, type: :request do
  before do
    @user = FactoryBot.build(:user)
    @party = FactoryBot.build(:party)
    @review = FactoryBot.build(:review)
  end

  describe 'GET /sessions/new' do
    it 'ログインページにリクエストすると正常にレスポンスが返ってくる' do
      get new_user_session_path
      expect(response.status).to eq 200
    end

    # it "indexアクションにリクエストするとレスポンスに投稿済みのpartyの名前が存在する" do
    #   get root_path
    #   expect(response.body).to include(@review.title)
    #   expect(response.body).to include (@party)
    #   expect(assigns(:party)).to eq party
    # end
  end

  # describe 'user1で' do
  #   it 'ログインに成功すること' do
  #     get new_user_session_path(@user.id)
  #     binding.pry
  #     expect(response).to redirect_to root_path
  #   end
  # end
end
