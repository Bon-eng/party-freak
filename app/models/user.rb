class User < ApplicationRecord
  
  has_many :parties
  has_many :reviews

  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :gender
  belongs_to :genre

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
end
