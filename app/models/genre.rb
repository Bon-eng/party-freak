class Genre < ApplicationRecord

  self.data = [
    { id: 1, name: '-----' },
    { id: 2, name: 'EDM' },
    { id: 3, name: 'Rock' },
    { id: 4, name: 'Trance' },
    { id: 5, name: 'Techno' },
    { id: 6, name: 'Drum & Bass' }
    { id: 7, name: 'Bass Music' },
    { id: 8, name: 'Hip Hop' }
    { id: 9, name: '主要なジャンルほぼ全て' }
  ]

  include ActiveHash::Associations
  has_many :parties

end
