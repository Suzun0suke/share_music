# README

## アプリケーション概要
ShareMusicはSpotifyで作成したプレイリストを共有することができるアプリケーションです。
利用ユーザーはプレイリストの投稿、投稿されたプレイリストを利用することができます。
また、検索やハッシュタグを利用することで、自分の聞きたいプレイリストを探すことができます。

## URL

## テスト用アカウント
Email: test@com
password: test123

## 利用方法
アカウントにログインし、投稿画面に遷移します。
プレイリストのタイトル、spotifyのプレイリストのurl、画像を添付することで投稿することが可能です。
また、投稿一覧から興味のあるプレイリストをクリックし、「spotifyで聴く」をクリックすることでspotifyに遷移することが可能です。

## 目指した課題解決
音楽を聴くことが好きな人たちが、新しい音楽と出会うことができるように、シーンに合った音楽を簡単に見つけることができるようにアプリの作成を行いました。

## 洗い出した用件
- ユーザー管理機能
- プレイリスト投稿機能
- タグ機能
- 検索機能
- いいね機能
- ランキング機能
- SNS共有機能

## 操作概要
- プレイリスト投稿機能
- タグ機能
- 検索機能
- いいね機能
- ランキング機能
- SNS共有機能

## 実装予定の機能
- 他の音楽配信サービスによる投稿
- フォロー機能
- iOS用アプリの作成

## データベース設計
- ER図
https://gyazo.com/f3571c2c79f1109b6f7e271c10028c4b

### usersテーブル
| Column             | Type          | Options                   | 
| ------------------ | ------------- | ------------------------- | 
| name               | string        | null: false, unique: true | 
| encrypted_password | string        | null: false               | 
| email              | string        | null: false               | 
| image              | ActiveStorage |                           | 

#### Association
- has_many :posts
- has_many :likes
- has_one_attached :image

### postsテーブル
| Column | Type          | Options                        | 
| ------ | ------------- | ------------------------------ | 
| title  | string        | null: false                    | 
| url    | string        | null: false                    | 
| image  | ActiveStorage |                                | 
| user   | references    | null: false, foreign_key: true | 

#### Association
- has_many :likes
- belongs_to :user
- has_one_attached :image
- has_many :tags, through :post_tags

### likesテーブル
| Column | Type       | Options                        | 
| ------ | ---------- | ------------------------------ | 
| user   | references | null: false, foreign_key: true | 
| post   | references | null: false, foreign_key: true | 

#### Association
- belongs_to :user
- belongs_to :post

## ローカルでの動作方法
①
②
③