require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  #全16項目

  describe '新規登録/ユーザー情報' do
    context '新規登録がうまくいくとき'
    it '記入欄の全てが存在すれば登録できる' do
      expect(@user).to be_valid
    end
  end

  context '新規登録がうまくいかないとき' do
    it 'nicknameが必須であること' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('ニックネームを入力してください')
    end

    it 'emailが必須であること' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('Eメールを入力してください')
    end

    it 'emailが一意性であること' do
      @user.save
      another_user = FactoryBot.create(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
    end

    it 'emailは@を含むこと' do
      @user.email = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Eメールは不正な値です')
    end

    it 'passwordが必須であること' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードを入力してください', 'パスワード（確認用）とパスワードの入力が一致しません')
    end

    it 'passwordが6文字以上必須であること' do
      @user.password = '11111'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
    end

    it 'passwordが半角数字のみの場合登録できない' do
      @user.password = '111111'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは不正な値です')
    end

    it 'passwordが半角英字のみの場合登録できない' do
      @user.password = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは不正な値です')
    end

    it 'passwordが全角英数字のみの場合登録できない' do
      @user.password = 'Ａ１１１１１'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは不正な値です')
    end

    it 'passwordとpassword確認用の値が一致していないと登録できない' do
      @user.password = 'a11111'
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
    end

    it '性別に情報を入れないと登録できない' do
      @user.gender_id = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('性別を入力してください')
    end

    it '性別の情報が必須であること' do
      @user.gender_id = '1'
      @user.valid?
      expect(@user.errors.full_messages).to include('性別を入力してください')
    end

    it 'プロフィールが必須であること' do
      @user.profile = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('プロフィールを入力してください')
    end

    it '好きなジャンルに情報を入れないと登録できない' do
      @user.genre_id = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('好きなジャンルを入力してください')
    end

    it '好きなジャンルの情報が必須であること' do
      @user.genre_id = '1'
      @user.valid?
      expect(@user.errors.full_messages).to include('好きなジャンルを入力してください')
    end
  end
end
