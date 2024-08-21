

## users テーブル

| Column                | Type   | Options     |
| ----------------------| ------ | ----------- |
| nickname              | string | null: false |
| email                 | string | null: false, unique: true |
| password              | string | null: false |
| password_confirmation | string | null:false  |
| full_name             | string | null:false  |
| full_name_kana        | string | null:false  |
| date_of_birth         | date   | null:false  |

### Association

- has_many :products
- has_many :orders


## addresses テーブル

| Column        | Type   | Options     |
| ------------- | ------ | ----------- |
| postal_code   | string | null: false |
| region         | string | null: false |
| city          | string | null: false |
| street        | string | null: false |
| building_name | string | null: true |
| phone_number  | string | null: false |
| order_id       | integer | null: false, foreign_key: true|

### Association

- belongs_to :order


## products テーブル

| Column        | Type   | Options     |
| --------------| ------ | ----------- |
| name          | string | null: false |
| image_url     | string | null: false |
| description   | text   | null: false |
| category      | string | null: false |
| condition     | string | null: false |
| price         | integer | null: false |
| user_id       | integer | null: false, foreign_key: true|

### Association

- belongs_to :user
- has_one :order

## orders テーブル

| Column     | Type   | Options     |
| ---------- | ------ | ----------- |
| price      | integer | null: false |
| status     | string | null: false |
| product_id | integer | null: false, foreign_key: true|
| address_id | integer | null: false, foreign_key: true|
| user_id    | integer | null: false, foreign_key: true|

### Association

- belongs_to :user
- belongs_to :product
- has_one :address