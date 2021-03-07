require 'rails_helper'
RSpec.describe 'Reviews', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:party) { FactoryBot.create(:party, user_id: user.id) }
  before do
    @current_user_review = FactoryBot.create(:review, user: user, party: party)
  end
  #全6項目

  context '新規レビュー投稿ができるとき' do
    it '正しい情報を入力すれば新規レビュー投稿ができる' do
      # ログインする
      login(user)
      # 新規登録ページへ移動する
      visit party_path(party.id)
      # レビュー情報を入力する
      fill_in 'レビュータイトル', with: '俺はジャイアン'
      fill_in 'レビュー本文', with: 'ガキ大将'
      attach_file '画像', 'spec/images/test.jpg'
      # 新規登録ボタンを押すとレビューモデルのカウントが1上がることを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { Review.count }.by(1)
      # レビューの投稿ができたことを確認する
      expect(page).to have_content 'レビューの投稿ができました。'
    end
  end
  context '新規レビュー投稿ができないとき' do
    it '誤った情報では新規レビュー投稿ができない' do
      # ログインする
      login(user)
      # 新規登録ページへ移動する
      visit party_path(party.id)
      # レビュー情報を入力する
      fill_in 'レビュータイトル', with: ''
      fill_in 'レビュー本文', with: ''
      # 新規登録ボタンを押すとレビューモデルのカウントが1上がらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Review.count }.by(0)
      # レビューの投稿ができたことを確認する
      expect(page).to have_content 'レビューの投稿ができませんでした。'
    end
  end

  describe 'レビューの編集' do
    before do
      login(user)
      visit edit_party_review_path(party.id, @current_user_review.id)
    end
    context 'レビューの編集画面に遷移する' do
      it '編集画面で対象のデータが表示されている' do
        # レビュータイトルにデータが入っていることを確認する
        expect(page).to have_field 'レビュータイトル', with: @current_user_review.title
        # レビュー本文にデータが入っていることを確認する
        expect(page).to have_field 'レビュー本文', with: @current_user_review.content
      end
      it 'レビュー情報が編集できる' do
        # レビュー情報を入力する
        fill_in 'レビュータイトル', with: 'おまえのもはおれのもの'
        fill_in 'レビュー本文', with: 'おれのものもおれのもの・・・な！！'
        attach_file '画像', 'spec/images/test.jpg'
        # 保存ボタンを押す
        find('input[name="commit"]').click
        # 「レビューの編集ができました。」のflashメッセージが表示されていることを確認する
        expect(page).to have_content 'レビューの編集ができました。'
        # 編集した内容が表示されていることを確認する
        expect(page).to have_content 'おまえのもはおれのもの'
        expect(page).to have_content 'おれのものもおれのもの・・・な！！'
      end
    end

    context 'レビューの編集ができないとき' do
      it '項目に不備があると編集できない' do
        # レビュー情報を入力する
        fill_in 'レビュータイトル', with: ''
        fill_in 'レビュー本文', with: ''
        # 保存ボタンを押す
        find('input[name="commit"]').click
        # 「レビューの編集ができませんでした。」のflashメッセージが表示されていることを確認する
        expect(page).to have_content 'レビューの編集ができませんでした。'
      end
    end
  end

  describe 'レビューの削除' do
    before do
      login(user)
    end
    context 'レビューの削除ができるとき' do
      it '本人が投稿したレビューは削除ができる' do
        # 表示されているユーザーの名前をクリック
        find('.user_name').click
        # 表示されている削除するをクリック
        click_link '削除する', match: :first
        # 「レビューの削除ができました。」のflashメッセージが表示されていることを確認する
        expect(page).to have_content 'レビューの削除ができました。'
      end
    end
  end
end
