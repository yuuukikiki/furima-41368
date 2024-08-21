

## users テーブル

| Column                | Type   | Options     |
| ----------------------| ------ | ----------- |
| nickname              | string | null: false |
| email                 | string | null: false, unique: true |
| encrypted_password    | string | null: false  |
| last_name             | string | null: false  |
| first_name            | string | null: false  |
| last_name_kana        | string | null: false  |
| first_name_kana       | string | null: false  |
| date_of_birth         | date   | null: false  |

### Association

- has_many :products
- has_many :orders


## addresses テーブル

| Column        | Type       | Options     |
| ------------- | ---------- | ----------- |
| postal_code   | string     | null: false |
| city          | string     | null: false |
| street        | string     | null: false |
| building_name | string     | null: true  |
| phone_number  | string     | null: false |
| order         | references | null: false, foreign_key: true|
| prefecture_id | integer    | null: false |    

### Association

- belongs_to :order
- belongs_to_active_hash :prefecture



## products テーブル

| Column           | Type       | Options     |
| -----------------| ---------- | ----------- |
| name             | string     | null: false |
| description      | text       | null: false |
| category_id      | integer    | null: false |
| condition_id     | integer    | null: false |
| shipping_fee_id  | integer    | null: false |
| shipping_time_id | integer    | null: false |
| price            | integer    | null: false |
| user             | references | null: false, foreign_key: true|
| prefecture_id    | integer    | null: false |    


### Association

- belongs_to :user
- has_one :order
- belongs_to_active_hash :prefecture


## orders テーブル

| Column     | Type      | Options     |
| ---------- | --------- | ----------- |
| product    | reference | null: false, foreign_key: true  |
| user       | reference | null: false, foreign_key: true  |

### Association

- belongs_to :user
- belongs_to :product
- has_one :address