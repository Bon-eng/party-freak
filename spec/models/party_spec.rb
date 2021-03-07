require 'rails_helper'
RSpec.describe Party, type: :model do
  before do
    @party = FactoryBot.build(:party)
  end
  #全7項目
  
  describe '新規登録/Party情報' do
    context '新規登録がうまくいくとき'
    it '記入欄の全てが存在すれば登録できる' do
      expect(@party).to be_valid
    end
  end

  context '新規登録がうまくいかないとき' do
    it 'nameが必須であること' do
      @party.name = ''
      @party.valid?
      expect(@party.errors.full_messages).to include('Partyの名前を入力してください')
    end

    it 'introductionが必須であること' do
      @party.introduction = ''
      @party.valid?
      expect(@party.errors.full_messages).to include('紹介文を入力してください')
    end

    it 'season_idが必須であること' do
      @party.season_id = ''
      @party.valid?
      expect(@party.errors.full_messages).to include('開催時期を入力してください')
    end

    it 'country_idが必須であること' do
      @party.country_id = ''
      @party.valid?
      expect(@party.errors.full_messages).to include('開催地域を入力してください')
    end

    it 'genre_idが必須であること' do
      @party.genre_id = ''
      @party.valid?
      expect(@party.errors.full_messages).to include('ジャンルを入力してください')
    end

    it 'official_urlが必須であること' do
      @party.official_url = ''
      @party.valid?
      expect(@party.errors.full_messages).to include('オフィシャルHPを入力してください')
    end
  end
end
