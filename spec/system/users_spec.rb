require 'rails_helper'

RSpec.describe 'User', type: :system do
  let(:user) { FactoryBot.create(:user) }
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
      click_link '新規登録'
      # ユーザー情報を入力する
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード（6文字以上）', with: @user.password
      fill_in 'パスワード再入力', with: @user.password_confirmation
      fill_in 'ユーザー名', with: @user.nickname
      select '男性', from: '性別'
      select 'EDM', from: '好きなジャンル'
      fill_in 'プロフィール', with: @user.profile
      # 新規登録ボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq root_path
      # ログアウトボタンが表示されていることを確認する
      expect(page).to have_content('ログアウト')
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
      click_link '新規登録'
      # ユーザー情報を入力する
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード（6文字以上）', with: ''
      fill_in 'パスワード再入力', with: ''
      fill_in 'ユーザー名', with: ''
      select '-----', from: '性別'
      select '-----', from: '好きなジャンル'
      fill_in 'プロフィール', with: ''
      # 新規登録ボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq '/users'
    end
  end

  describe 'ログイン', type: :system do
    context 'ログインができるとき' do
      it '保存されているユーザー情報と合致すればログインができる' do
        # トップページに移動する
        visit root_path
        # トップページにログインボタンがあることを確認する
        expect(page).to have_content('ログイン')
        # ログインページへ遷移する
        click_link 'ログイン'
        # 保存されているユーザー情報を入力する
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        # ログインボタンを押す
        find('input[name="commit"]').click
        # トップページへ遷移したことを確認する
        expect(current_path).to eq root_path
        # ログアウトボタンが表示されていることを確認する
        expect(page).to have_content('ログアウト')
        # 「ログインしました。」のflashメッセージが表示されていることを確認する
        expect(page).to have_content('ログインしました。')
        # 新規登録ボタンが表示されていないことを確認する
        expect(page).to have_no_content('新規登録')
      end
    end

    context 'ログインができないとき' do
      it '保存されているユーザーの情報と合致しないとログインができない' do
        # トップページに移動する
        visit root_path
        # トップページにログインページへ遷移するボタンがあることを確認する
        expect(page).to have_content('ログイン')
        # ログインページへ遷移する
        click_link 'ログイン'
        # ユーザー情報を入力する
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: ''
        # ログインボタンを押す
        find('input[name="commit"]').click
        # 「Eメールまたはパスワードが違います。」のflashメッセージが表示されていることを確認する
        expect(page).to have_content('Eメールまたはパスワードが違います。')
        # ログインページへ戻されることを確認する
        expect(current_path).to eq new_user_session_path
      end
    end

    describe 'ログアウト' do
      before do
        login(user)
      end
      context 'ログアウトできるとき' do
        it 'ログアウトボタンをクリックするとトップページに移動する' do
          # ログアウトボタンを押す
          click_link 'ログアウト'
          # 「ログアウトしました。」のflashメッセージが表示されていることを確認する
          expect(page).to have_content('ログアウトしました。')
          # トップページにログインページへ遷移するボタンがあることを確認する
          expect(page).to have_content('ログイン')
          # ログインページへ戻されることを確認する
          expect(root_path).to eq root_path
        end
      end
    end

    describe 'ユーザー情報' do
      before do
        login(user)
      end
      context 'ユーザー情報に移動する' do
        it '表示されているユーザーの名前をクリックするとユーザー情報に移動する' do
          # 表示されているユーザーの名前をクリック
          find('.user_name').click
          # 性別が表示されていることを確認する
          expect(page).to have_css '.profile_gender'
          # 好きなジャンルが表示されていることを確認する
          expect(page).to have_css '.profile_genre'
          # プロフィールが表示されていることを確認する
          expect(page).to have_css '.profile_value'
          # 「編集する」リンクが表示されていることを確認する
          expect(page).to have_content '編集する'
        end
      end

      context 'ユーザー情報編集画面' do
        before do
          visit edit_user_registration_path(user)
        end
        it 'ユーザー情報が表示される' do
          # ユーザー名編集フォームにユーザー名が表示される
          expect(page).to have_field 'ユーザー名', with: user.nickname
          # 性別編集フォームに性別が表示される
          expect(page).to have_select('user[gender_id]', options: ['-----', '男性', '女性', '無回答'])
          # 好きなジャンル編集フォームに好きなジャンルが表示される
          expect(page).to have_select('user[genre_id]',
                                      options: ['-----', 'EDM', 'Rock', 'Trance', 'Techno', 'Drum & Bass', 'Bass Music',
                                                'Hip Hop', '主要なジャンルほぼ全て'])
          # プロフィール編集フォームにプロフィールが表示される
          expect(page).to have_field 'プロフィール', with: user.profile
        end

        it 'ユーザー情報が編集できる' do
          # ユーザー情報を入力する
          fill_in 'ユーザー名', with: 'ドラえもん'
          select '無回答', from: 'user[gender_id]'
          select 'EDM', from: 'user[genre_id]'
          fill_in 'プロフィール', with: '未来の世界の猫型ロボット'
          # 保存ボタンを押す
          find('input[name="commit"]').click
          # 性別が表示されていることを確認する
          expect(page).to have_content('性別')
          # 好きなジャンルが表示されていることを確認する
          expect(page).to have_content('好きなジャンル')
          # プロフィールが表示されていることを確認する
          expect(page).to have_content('プロフィール')
          # 「ユーザー情報の編集ができました。」のflashメッセージが表示されていることを確認する
          expect(page).to have_content 'ユーザー情報の編集ができました。'
          # 編集した内容が表示されていることを確認する
          expect(page).to have_content '無回答'
          expect(page).to have_content 'EDM'
          expect(page).to have_content '未来の世界の猫型ロボット'
        end

        it 'ユーザー情報が編集できないとき' do
          # ユーザー情報を入力する
          fill_in 'ユーザー名', with: ''
          # 保存ボタンを押す
          find('input[name="commit"]').click
          # 「ニックネームを入力してください」のエラーメッセージが表示されていることを確認する
          expect(page).to have_content 'ニックネームを入力してください'
        end
      end
    end
  end
end
