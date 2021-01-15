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
    validates :comment

    with_options numericality: { other_than: 1, message: "を入力してください"} do
      validates :gender_id
      validates :genre_id
    end
  end
end
