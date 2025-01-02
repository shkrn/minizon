

user_ids = User.pluck(:id)
item_ids = Item.pluck(:id)

review_contents = [
  "とても良い商品です！また利用したいと思います。",
  "使いやすく、大変満足しています。",
  "デザインが気に入りました。色違いも検討中です。",
  "価格もお手頃で助かります。友人にも勧めたいです。",
  "少し気になる点もありましたが、全体的には満足です。",
  "期待通りの商品でした。買ってよかったです。",
  "迅速な対応ありがとうございました。",
  "梱包も丁寧で、安心して受け取ることができました。",
  "想像以上によい商品で、大変満足しています。",
  "思っていたより少し小さかったですが、問題なく使えます。"
]

100.times do |n|
  user_id = user_ids.sample
  item_id = item_ids.sample
  rating = rand(1..5)
  content = "商品#{item_id}に対するレビュー#{n + 1}です。" + review_contents.sample # 配列からランダムにレビュー内容を選択
  report = [true, false].sample

  Review.create!(
    user_id: user_id,
    item_id: item_id,
    rating: rating,
    content: content,
    report: report
  )
end

puts "レビューデータを#{Review.count}件作成しました。"