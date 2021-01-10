class User < ApplicationRecord
  
  has_many :parties
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
