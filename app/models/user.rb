class User < ApplicationRecord
  
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  
  
  has_many :parties
  has_many :reviews

  has_one_attached :image

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
  validates :password, format: { with: PASSWORD_REGEX }
  # パスワードが一致していなければいけない
  validates :password, confirmation: true

end
