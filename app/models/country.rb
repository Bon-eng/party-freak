class Country < ActiveHash::Base

  self.data = [
    { id: 1, name: '-----' },
    { id: 2, name: 'ヨーロッパ' },
    { id: 3, name: 'オセアニア' },
    { id: 4, name: 'アジア' },
    { id: 5, name: '南米' },
    { id: 6, name: '北米' }
  ]

  include ActiveHash::Associations
  has_many :parties

end
