class Party < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy

  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :season
  belongs_to :country
  belongs_to :genre

  def self.search(search)
    if search != ''
      Party.where('introduction LIKE(?)', "%#{search}%")
    else
      Party.all
    end
  end

  with_options presence: true do
    validates :name
    validates :introduction
    validates :official_url
    validates :image

    with_options numericality: { other_than: 1, message: 'を入力してください' } do
      validates :season_id
      validates :country_id
      validates :genre_id
    end
  end
end
