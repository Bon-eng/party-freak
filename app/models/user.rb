class User < ApplicationRecord
  
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  has_many :parties
  has_many :reviews

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :gender
  belongs_to :genre

  with_options presence: true do
    validates :nickname
    validates :profile

    with_options numericality: { other_than: 1, message: "を入力してください"} do
      validates :gender_id
      validates :genre_id
    end
  end
  # PASSWORD_REGEXをここで定義し、withの中で使う
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze

  #on: :create ➡️ createアクションの時にだけvalidatesをかける
  validates :password, format: { with: PASSWORD_REGEX }, on: :create
  # パスワードが一致していなければいけない
  validates :password, confirmation: true, on: :create

  def self.guest
    find_or_create_by!(email: 'test@test.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = 'ゲストユーザー'
      user.profile = 'ログインありがとうございます。'
      user.gender_id = '4'
      user.genre_id = '9'
    end
  end

end
