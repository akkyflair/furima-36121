# テーブル設計

## users(ユーザー情報) テーブル

| Column             | Type    | Options                  |
| ------------------ | ------- | -------------------------|
| nickname           | string  | null: false              |
| email              | string  | null: false unique: true |
| encrypted_password | string  | null: false              |
| family_name        | string  | null: false              |
| first_name         | string  | null: false              |
| family_name_kana   | string  | null: false              |
| first_name_kana    | string  | null: false              |
| birthday           | date    | null: false              |

## Association
- has_many :items
- has_many :orders

## items（商品情報） テーブル

| Column                 | Type       | Options                        |
| ---------------------- | ---------- | -------------------------------|
| title                  | string     | null: false                    |
| price                  | integer    | null: false                    |
| text                   | text       | null: false                    |
| user                   | references | null: false, foreign_key: true |
| category_id            | integer    | null: false                    |ActiveHash
| status_id              | integer    | null: false                    |ActiveHash
| delivery_fee_id        | integer    | null: false                    |ActiveHash
| prefecture_id          | integer    | null: false                    |ActiveHash
| delivery_date_id       | integer    | null: false                    |ActiveHash

## Association
- belongs_to :user
- has_one :order

## orders(購入記録) テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| user            | references | null: false, foreign_key: true |
| item            | references | null: false, foreign_key: true |

- belongs_to :user
- belongs_to :item
- has_one :address

## addresses テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| postcode       | string     | null: false                    |
| prefecture_id  | integer    | null: false                    |
| city           | string     | null: false                    |
| block          | string     | null: false                    |
| building       | string     |                                |
| phone          | string     | null: false                    |
| order          | references | null: false, foreign_key: true |

## Association
- belongs_to :order