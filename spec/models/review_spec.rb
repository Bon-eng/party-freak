require 'rails_helper'

RSpec.describe Review, type: :model do

  before do
    @review = FactoryBot.build(:review)
    @review.image = fixture_file_upload('app/assets/images/test_image.jpg')
  end

  describe 'レビューの保存' do
    context 'レビューが投稿できる場合'
    it '記入欄の全てが存在すれば登録できる' do

      expect(@review).to be_valid
    end
  end

  #binding.pry
  context 'レビューが投稿できない場合' do
    it 'titleが必須であること' do
      @review.title = ''
      @review.valid?
      expect(@review.errors.full_messages).to include("Partyを入力してください", "レビュータイトルを入力してください")
    end

    it 'contentが必須であること' do
      @review.content = ''
      @review.valid?
      expect(@review.errors.full_messages).to include("Partyを入力してください", "レビュー本文を入力してください")
    end

    # it 'imageが必須であること' do
    #   @review.image = ''
    #   @review.valid?
    #   binding.pry
    #   expect(@review.errors.full_messages).to include("Partyを入力してください", "レビュー本文を入力してください")
    # end

  end
end
