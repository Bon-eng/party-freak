require 'rails_helper'

RSpec.describe 'Parties', type: :system do
  let(:admin_user) { FactoryBot.create(:user, admin: true) }
  describe 'adminユーザーのログイン機能' do
    context 'adminユーザーとしてログインできるとき' do
      it '正しい情報を入力すればadminユーザーとしてログインができてトップページに移動する' do
        # トップページに移動する
        visit root_path
        # トップページにログインボタンがあることを確認する
        expect(page).to have_content('ログイン')
        # ログインページへ遷移する
        click_link 'ログイン'
        # 保存されているユーザー情報を入力する
        fill_in 'メールアドレス', with: admin_user.email
        fill_in 'パスワード', with: admin_user.password
        # ログインボタンを押す
        find('input[name="commit"]').click
        # トップページへ遷移したことを確認する
        expect(current_path).to eq root_path
        # New Partyボタンが表示されていることを確認する
        expect(page).to have_content('New Party')
      end
    end
  end

  describe 'New Partyの投稿' do
    before do
      login(admin_user)
    end
    context 'New Partyの投稿ができるとき' do
      it '全ての項目に入力をすると編集ができる' do
        # トップページに移動する
        visit root_path
        # New Party投稿ページに遷移する
        click_link 'New Party'
        # Party情報を入力する
        fill_in 'Partyの名前', with: 'ドラえもん'
        fill_in '紹介文', with: '未来の世界の猫型ロボット'
        select '定期的に開催', from: 'party-season'
        select '北米', from: 'party-country'
        select '主要なジャンルほぼ全て', from: 'party-genre'
        fill_in 'オフィシャルHP', with: 'https:www.doraemon.com'
        attach_file '画像', 'spec/images/test.jpg'
        # 保存ボタンを押すとPartyモデルのカウントが1上がることを確認する
        expect do
          find('input[name="commit"]').click
        end.to change { Party.count }.by(1)
        # Partyの投稿ができたことを確認する
        expect(page).to have_content 'Partyの投稿ができました'
      end
    end
    context 'New Partyの投稿ができないとき' do
      it '項目に不備があると登録できない' do
        # 表示されているNew Partyをクリック
        click_link 'New Party'
        # Party情報を入力する
        fill_in 'Partyの名前', with: ''
        fill_in '紹介文', with: ''
        select '-----', from: 'party-season'
        select '-----', from: 'party-country'
        select '-----', from: 'party-genre'
        fill_in 'オフィシャルHP', with: ''
        # 保存ボタンを押すとPartyモデルのカウントは上がらないことを確認する
        expect  do
          find('input[name="commit"]').click
        end.to change { Party.count }.by(0)
        # Partyの投稿ができなかったことを確認する
        expect(page).to have_content 'Partyの投稿ができませんでした。'
      end
    end
  end

  describe 'Partyの編集と削除' do
    let(:party) { FactoryBot.create(:party, user_id: user.id) }
    before do
      login(admin_user)
    end
    context 'Partyの編集ができるとき' do
      it '全ての項目が入力されていると編集できる' do
        # 表示されている詳細を見るをクリック
        click_link '詳細を見る'
        # 表示されている編集するをクリック
        click_link '編集する'
        # Party情報を入力する
        fill_in 'Partyの名前', with: '野比のび太'
        fill_in '紹介文', with: 'あの青年は人の幸せを願い、人の不幸を悲しむことができる人だ。'
        select '決まっていない', from: 'party-season'
        select 'アジア', from: 'party-country'
        select 'Rock', from: 'party-genre'
        fill_in 'オフィシャルHP', with: 'https:www.nobinobita.com'
        attach_file '画像', 'spec/images/test.jpg'
        # 保存ボタンを押す
        find('input[name="commit"]').click
        # 「Partyの編集ができました。」のflashメッセージが表示されていることを確認する
        expect(page).to have_content 'Partyの編集ができました。'
        # 編集した内容が表示されていることを確認する
        expect(page).to have_content '野比のび太'
        expect(page).to have_content 'あの青年は人の幸せを願い、人の不幸を悲しむことができる人だ。'
        expect(page).to have_content '決まっていない'
        expect(page).to have_content 'アジア'
        expect(page).to have_content 'Rock'
        expect(page).to have_content 'https:www.nobinobita.com'
        # Partyの編集ができたことを確認する
        expect(page).to have_content 'Partyの編集ができました。'
      end
    end
    context 'Partyの編集ができないとき' do
      it '項目に不備があると編集できない' do
        # 表示されている詳細を見るをクリック
        click_link '詳細を見る'
        # 表示されている編集するをクリック
        click_link '編集する'
        # Party情報を入力する
        fill_in 'Partyの名前', with: ''
        # 保存ボタンを押す
        find('input[name="commit"]').click
        # 「Partyの編集ができませんでした。」のflashメッセージが表示されていることを確認する
        expect(page).to have_content 'Partyの編集ができませんでした。'
      end
    end
    context 'Partyの削除ができるとき' do
      it 'ボタンをクリックすると削除できる' do
        # 表示されている詳細を見るをクリック
        click_link '詳細を見る'
        # 表示されている削除するをクリック
        click_link '削除する'
        # 「Partyの削除ができました。」のflashメッセージが表示されていることを確認する
        expect(page).to have_content 'Partyの削除ができました。'
      end
    end
  end

  describe 'ログインしていないユーザーは投稿も編集もできない' do
    before do
      @party = FactoryBot.create(:party)
    end
    context 'ログインしていないユーザーはログインページへ遷移させる' do
      it 'Partyの投稿をしようとしたとき' do
        # 投稿編集ページにダイレクトに移動する
        visit new_party_path
        # 「アカウント登録もしくはログインしてください。」のflashメッセージが表示されていることを確認する
        expect(page).to have_content 'アカウント登録もしくはログインしてください。'
      end
      it 'Partyの編集をしようとしたとき' do
        # 投稿編集ページにダイレクトに移動する
        visit edit_party_path(@party)
        # 「アカウント登録もしくはログインしてください。」のflashメッセージが表示されていることを確認する
        expect(page).to have_content 'アカウント登録もしくはログインしてください。'
      end
    end
  end

  describe 'ログインしていてもadminユーザーでなければ投稿も編集もできない' do
    let(:user) { FactoryBot.create(:user) }
    before do
      @party = FactoryBot.create(:party)
      @user = FactoryBot.build(:user)
      login(user)
    end
    context 'ログインしていないユーザーはログインページへ遷移させる' do
      it 'Partyの投稿をしようとしたとき' do
        # 投稿編集ページにダイレクトに移動する
        visit new_party_path
        # 「無効なURLです。」のflashメッセージが表示されていることを確認する
        expect(page).to have_content '無効なURLです。'
      end
      it 'Partyの編集をしようとしたとき' do
        # 投稿編集ページにダイレクトに移動する
        visit edit_party_path(@party)
        # 「無効なURLです。」のflashメッセージが表示されていることを確認する
        expect(page).to have_content '無効なURLです。'
      end
    end
  end
end
