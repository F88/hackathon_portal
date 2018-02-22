# ハッカソンポータル

## 紹介

新着のハッカソン・ゲームジャム・アイディアソン・開発合宿の情報を自動的にお知らせしているBotです。よかったらフォローしてください!!

 * Twitter: https://goo.gl/9462Kk
 * Qiita: https://goo.gl/bkdJRb

ここではその処理の中身を公開しています。

## 解説

Qiitaの方がよりまとまった情報として紹介しています。
Twitterでは開催情報についてつぶやきますが、今後はハッカソンイベントが盛り上がるようなこともつぶやく予定です。
また、現在、日本で開催する情報を中心にお知らせしていますが、海外でこのような情報を収集できるサイトがあり、ニーズがありそうでしたら導入を検討します。

## 情報を集めているサービス
 * [Connpass](https://connpass.com/)
 * [Atnd](https://atnd.org/)
 * [Doorkeeper](https://www.doorkeeper.jp/)
 * [Peatix](https://peatix.com/)

このほかに追加で収集してほしいサービスとかありましたら、issueなどで述べてください。また、管理ツールもあります。管理ツールを使ってみたい!!など、希望の方は[Facebookアカウント](https://www.facebook.com/taku.kobayashi.560)などから個別にご連絡ください。

## 技術的なお話
cronを使い、毎日定刻にて、自動的に情報を集めて、それぞれのアカウントに投稿しています。
タイトルや詳細文からハッカソンに関するものなのかどうか推測し、判断した上で投稿するようにしています。
.envの中にapikeyやアクセストークンなどの詳細な情報を記載しています。流用したい場合などは、.env.sampleを.envに改名して、必要な情報を入力して実行してください。