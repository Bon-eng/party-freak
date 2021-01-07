# README



## users テーブル
| Column   | Type    | Options                   |
| -------- | ------- | ------------------------- |
| nickname | string  | null: false               |
| gender   | integer | null: false               |
| email    | string  | null: false, unique: true |
| password | string  | null: false               |
| avatar   | blob    |                           |
| comment  | text    |                           |
| genre_id | integer |                           |

### Association
- has_many :reviews



## parties テーブル
| Column       | Type    | Options     |
| ------------ | ------- | ----------- |
| name         | string  | null: false |
| introduction | text    | null: false |
| date_id      | integer | null: false |
| country_id   | integer | null: false |
| genre_id     | integer | null: false |


### Association
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