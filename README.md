# RestaurantSearcherApp  
## 概要  
このアプリはホットペッパーグルメAPIを使って、現在地を取得し、近くの飲食店をマップを使って探せるアプリです。検索ボタンの横の検索結果一覧ボタンを押すと、検索に引っかかった飲食店を一覧できます。  
アプリ起動時に自動で近くの飲食店を検索して表示しています。店舗詳細画面へは、検索一覧画面のセルをタップするか、マップのピンをタップすると店舗詳細画面へ画面遷移できます。  
  
## 開発環境  
Xcode 12.5  
Swift 5.4  
  
対象OS  
iOS 14.6  
  
## 画面概要  
マップ画面: 画面起動時に自動で近くの飲食店を検索。ピンを押すと店舗詳細画面へ画面遷移。テキストフィールドにキーワードを入力し、飲食店を検索。検索ボタンの横の検索結果一覧ボタンを押すと検索に引っかかった飲食店を一覧。  

検索結果一覧画面: マップ画面で検索に引っかかった飲食店を一覧できる。店舗名、アクセス、営業時間、画像が見れる。セルをタップすると、店舗詳細画面へ画面遷移。  

店舗詳細画面: この画面では、店舗名、キャッチフレーズ、住所、アクセス、営業時間、駐車場の有無、画像が見れる。  
  
## ライブラリ (今回はSwift Package Manegerでインストールしました。)     
[Alamofire 5.4.3](https://github.com/Alamofire/Alamofire)  
[Nuke 10.2.0](https://github.com/kean/Nuke)  
  
## こだわったポイント  
こだわったポイントは、使い方です。マップを実装して、飲食店の場所が具体的に分かるようにしました。使い方をシンプルにすることによって、誰でも使えるアプリにできるからです。そして、検索結果を最大30件にし、たくさんの飲食店検索できるようにしました。  
  
## デザイン面でこだわったポイント  
デザイン面は、色と店舗情報のレイアウトです。色はやはり食べ物系はオレンジだと思いオレンジにしました。できるだけ、オレンジを濃くせず、少し薄い感じにすることで違和感をなくせると考えこのような色を採用しました。  
店舗情報のレイアウトは、どのようにすれば情報が見やすいか考えた結果、このようなレイアウトになりました。検索結果一覧画面では、画像を丸くすることで少し優しい印象を持てるかなと思い、丸くしました。店舗詳細画面では、戻るボタンの位置に苦戦しました。  
  
  
  
## 自己評価  
100点満点中75点です。最低実装しなくてはいけない機能や店舗情報は実装できたと思うので75点にしました。あとの25点はUIとマップの機能です。経路やピンにお店の画像を付けたかったのですが、できなかったので悔しいです。  
  

  
## スクリーンショット  
<img src="https://user-images.githubusercontent.com/65600700/122054456-a822e080-ce22-11eb-8219-ec35c8df7a0f.png" width="250px">  <img src="https://user-images.githubusercontent.com/65600700/122054602-ca1c6300-ce22-11eb-85ed-51459c35e544.png" width="250px"> <img src="https://user-images.githubusercontent.com/65600700/122054764-f2a45d00-ce22-11eb-94bd-be2d3507ec08.png" width="250px">

<img src="https://user-images.githubusercontent.com/65600700/122054870-0a7be100-ce23-11eb-8d90-7efeef9b0707.png" width="250px">  <img src="https://user-images.githubusercontent.com/65600700/122056038-2cc22e80-ce24-11eb-8eba-b03f97cbc72e.png" width="250px">  <img src="https://user-images.githubusercontent.com/65600700/122056877-0355d280-ce25-11eb-8edc-c08152d840fe.png" width="250px">  <img src="https://user-images.githubusercontent.com/65600700/122057440-9a228f00-ce25-11eb-9a7c-15702d1284b4.png" width="250px">
  
