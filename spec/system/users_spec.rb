require 'rails_helper'

RSpec.describe 'User', type: :system do

  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # トップページに新規登録ボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード（6文字以上）', with: @user.password
      fill_in 'パスワード再入力', with: @user.password_confirmation
      fill_in 'ユーザー名', with: @user.nickname
      select '男性', from: '性別'
      select 'EDM', from: '好きなジャンル'
      fill_in 'プロフィール', with: @user.profile
      # 新規登録ボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq root_path
      # 新規登録ボタンとログインボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページに新規登録ボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'メールアドレス', with: ""
      fill_in 'パスワード（6文字以上）', with: ""
      fill_in 'パスワード再入力', with: ""
      fill_in 'ユーザー名', with: ""
      select '-----', from: '性別'
      select '-----', from: '好きなジャンル'
      fill_in 'プロフィール', with: ""
      # 新規登録ボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq "/users"
    end
  end
end