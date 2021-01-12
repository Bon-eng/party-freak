# README



## users テーブル
| Column    | Type    | Options                   |
| --------  | ------- | ------------------------- |
| nickname  | string  | null: false               |
| email     | string  | null: false, unique: true |
| password  | string  | null: false               |
| gender_id | integer | null: false               |
| comment   | text    |                           |
| genre_id  | integer |                           |

### Association
- has_many :parties
- has_many :reviews



## parties テーブル
| Column       | Type    | Options     |
| ------------ | ------- | ----------- |
| name         | string  | null: false |
| introduction | text    | null: false |
| season_id      | integer | null: false |
| country_id   | integer | null: false |
| genre_id     | integer | null: false |
| picture      | text    | null: false |

### Association
- belongs_to :party
- has_many :reviews



## reviews テーブル
| Column   | Type    | Options     |
| -------- | ------- | ----------- |
| title    | string  | null: false |
| content  | text    | null: false |
| score    | float   | null: false |
| trip     | text    |             |
| money_id | integer | null: false |
| meal_id  | integer | null: false |
| item     | text    |             |

### Association
- belongs_to :user
- belongs_to :party