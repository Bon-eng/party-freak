class Season < ApplicationRecord

  self.data = [
    { id: 1, name: '-----' },
    { id: 2, name: '1月~3月' },
    { id: 3, name: '4月~6月' },
    { id: 4, name: '7月~9月' },
    { id: 5, name: '10月~12月' }
  ]

  include ActiveHash::Associations
  has_many :parties

end
