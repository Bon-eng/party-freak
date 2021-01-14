class Review < ApplicationRecord

  belongs_to :user
  belongs_to :party

  has_one_attached :image

  with_options presence: true do
    validates :title
    validates :content
    # validates :score
    validates :image
  end
end
