items = ["item1", "item2", "item3", "item4", "item5", "item6", "item7", "item8", "item9", "item10"]

items.each_with_index do |i, index|
    Item.create!(
        user_id: 3,
        category_id: 1,
        name: i,
        code: index + 1,
        stock: 100,
        description: "this is description",
        new: true,
        status: 0,
        price: 1000
    )
end

filename = "noimage.jpg"
path = Rails.root.join(__dir__, "img/"+filename)



Item.all.each do |m|
    File.open(path) do |f|
        m.item_picture.attach(io: f, filename: filename)
    end
end

items = [
    { name: "4K液晶テレビ 50インチ", image: "tv.png", category_id: 1, code: "AV-001", stock: 50, description: "高画質4K対応の大画面テレビ。迫力のある映像体験を提供し、鮮明な色彩と細部まで再現される映像が特徴です。エンターテインメントやスポーツ観戦に最適です。", price: 89800 },
    { name: "ステンレス製フライパン 26cm", image: "fp.png", category_id: 2, code: "KT-002", stock: 100, description: "耐久性に優れたステンレス製のフライパン。均一に熱を伝え、焦げ付きにくくお手入れも簡単です。高温調理にも対応し、家庭料理からプロの調理まで幅広く活用できます。", price: 3980 },
    { name: "メンズ Tシャツ (Mサイズ/ホワイト)", image: "ts.png", category_id: 3, code: "FA-003", stock: 200, description: "着心地の良いコットン100%のTシャツ。肌触りが柔らかく、通気性に優れているため、一日中快適に過ごせます。カジュアルなスタイルに合わせやすく、様々なコーディネートに最適です。", price: 1980 },
    { name: "小説：星の王子さま", image: "sp.png", category_id: 4, code: "BK-004", stock: 80, description: "世代を超えて愛される不朽の名作『星の王子さま』。深い哲学的テーマと心温まる物語が織り交ぜられ、読む人の心に響く感動的な一冊です。大切な人へのギフトにも最適です。", price: 780 },
    { name: "ワイヤレスイヤホン", image: "ew.png", category_id: 1, code: "AV-005", stock: 120, description: "高音質で快適なワイヤレスイヤホン。ノイズキャンセリング機能搭載で、外部の雑音を遮断し、クリアな音楽体験を提供します。長時間の使用でも疲れにくく、通勤や運動時にも最適です。", price: 5980 },
    { name: "ゲーミングPC", image: "gp.png", category_id: 6, code: "PC-001", stock: 30, description: "高性能グラフィックボードと最新プロセッサを搭載したゲーミングPC。高速な処理能力と優れた冷却システムにより、長時間のプレイでも快適な環境を維持します。多彩な接続オプションでカスタマイズも可能です。", price: 150000 },
    { name: "ぬいぐるみ くま", image: "bm.png", category_id: 7, code: "TY-001", stock: 70, description: "ふわふわで可愛いクマのぬいぐるみ。高品質な素材で作られており、抱き心地が良く、長く愛用できます。子供へのプレゼントやインテリアとしても人気です。", price: 2980 },
    { name: "リップスティック", image: "ls.png", category_id: 8, code: "CM-001", stock: 150, description: "発色が良く、長時間キープするリップスティック。豊富なカラーバリエーションで、様々なシーンに合わせてお好みの色をお選びいただけます。保湿成分配合で唇をしっとりと保ちます。", price: 1200 },
    { name: "ランニングシューズ", image: "rs.png", category_id: 9, code: "SP-001", stock: 90, description: "軽量でクッション性の高いランニングシューズ。足への負担を軽減し、快適なランニングをサポートします。通気性に優れた素材を使用しており、長時間の使用でも蒸れにくい設計です。", price: 7980 },
    { name: "木製ダイニングテーブル", image: "dt.png", category_id: 10, code: "IN-001", stock: 40, description: "温かみのある木製ダイニングテーブル。丈夫な構造と美しい仕上げで、家族団らんの時間を豊かにします。サイズやデザインも豊富で、様々なインテリアスタイルにマッチします。", price: 39800 },
    { name: "エレキギター", image: "eg.png", category_id: 11, code: "MG-001", stock: 20, description: "初心者にもおすすめのエレキギター。高品質な音材と精密な製造工程により、クリアで豊かな音色を実現。練習用からライブパフォーマンスまで幅広く活躍します。", price: 24800 },
    { name: "バイクヘルメット", image: "hm.png", category_id: 12, code: "MC-001", stock: 60, description: "安全性を考慮したバイクヘルメット。高強度の素材と先進的なデザインで、頭部をしっかりと保護。通気性にも優れ、快適なライディングをサポートします。", price: 9800 },
    
    { name: "ミラーレス一眼カメラ", image: "ml.png", category_id: 1, code: "AV-007", stock: 25, description: "高性能ミラーレス一眼カメラ。軽量ボディながら、優れた画質と高速なオートフォーカスを実現。様々なレンズとアクセサリーに対応し、クリエイティブな撮影をサポートします。", price: 120000 },
    { name: "オーブントースター", image: "ot.png", category_id: 2, code: "KT-003", stock: 60, description: "多機能オーブントースター。均一な焼き上がりと短い加熱時間で、美味しいトーストを簡単に作れます。設定も直感的で使いやすく、忙しい朝にもぴったりです。", price: 15000 },
    { name: "電気ケトル", image: "kt.png", category_id: 2, code: "KT-004", stock: 80, description: "急速沸騰電気ケトル。高出力で短時間にお湯を沸かすことができ、忙しい朝や急な来客にも対応可能です。安全機能も充実しており、安心してお使いいただけます。", price: 5000 },
    { name: "Tシャツ(白/M)", image: "wt.png", category_id: 3, code: "FA-004", stock: 150, description: "定番の白Tシャツ。柔らかいコットン素材を使用し、肌触りが良く快適な着心地を提供します。シンプルなデザインで、様々なスタイルに合わせやすく、ワードローブの必需品です。", price: 3000 },
    { name: "デニムパンツ(L)", image: "dp.png", category_id: 3, code: "FA-005", stock: 100, description: "履き心地の良いデニムパンツ。丈夫な素材と洗練されたシルエットで、カジュアルからスマートカジュアルまで幅広く着こなせます。長持ちする品質で、日常の様々なシーンに最適です。", price: 8000 },
    { name: "小説「夜が明ける」", image: "nb.png", category_id: 4, code: "BK-005", stock: 50, description: "話題のベストセラー小説『夜が明ける』。深い人間ドラマと繊細な描写が魅力で、読者を引き込むストーリーテリングが特徴です。感動と共感を呼ぶ作品です。", price: 1800 },
    { name: "漫画「冒険の書」1巻", image: "ab.png", category_id: 4, code: "BK-006", stock: 70, description: "大人気冒険漫画『冒険の書』第1巻。魅力的なキャラクターとエキサイティングなストーリー展開で、読む手を止められません。継続的に楽しめるシリーズです。", price: 500 },
    { name: "ぬいぐるみ(動物)", image: "bp.png", category_id: 7, code: "TY-002", stock: 80, description: "かわいい動物のぬいぐるみ。柔らかい素材で作られており、抱きしめると心が温まります。子供部屋やリビングのインテリアとしてもおすすめです。", price: 2000 },
    { name: "掛け時計", image: "clk.png", category_id: 10, code: "IN-002", stock: 50, description: "おしゃれな掛け時計。シンプルで洗練されたデザインがどんなインテリアにもマッチし、時間を美しく表示します。高品質な素材と精密なメカニズムで、長くご使用いただけます。", price: 5000 },
    { name: "コーヒーメーカー", image: "cm.png", category_id: 2, code: "KT-005", stock: 40, description: "全自動コーヒーメーカー。ワンタッチで美味しいコーヒーを淹れることができ、忙しい朝やリラックスタイムに最適です。多機能な設定で、お好みの濃さや温度に調整可能です。", price: 20000 },
    { name: "ビジネスバッグ", image: "bb.png", category_id: 3, code: "FA-006", stock: 120, description: "多機能ビジネスバッグ。収納力に優れ、ノートパソコンや書類をしっかりと収納できます。耐久性の高い素材と洗練されたデザインで、ビジネスシーンにぴったりです。", price: 15000 },
    { name: "ボードゲーム", image: "bg.png", category_id: 5, code: "BG-001", stock: 90, description: "家族で楽しめるボードゲーム。戦略性と運の要素が絶妙に組み合わさり、何度でも飽きずに遊べます。コミュニケーションを深めるのに最適で、パーティーや集まりにもぴったりです。", price: 4000 },
    { name: "圧力鍋 5L", image: "pc.png", category_id: 2, code: "KT-007", stock: 80, description: "時短調理に便利な圧力鍋。素材の旨みを閉じ込め、美味しく調理できます。", price: 9800 },
    { name: "包丁セット 3本組", image: "ks.png", category_id: 2, code: "KT-008", stock: 60, description: "様々な用途に使える包丁セット。切れ味と使いやすさを追求。", price: 7980 },
    { name: "レディース ワンピース (M/黒)", image: "dr.png", category_id: 3, code: "FA-008", stock: 150, description: "上品でエレガントなレディースワンピース。パーティーやフォーマルなシーンにも。", price: 12800 },
    { name: "メンズ ジャケット (L/ネイビー)", image: "jk.png", category_id: 3, code: "FA-009", stock: 100, description: "ビジネスシーンにもカジュアルにも使えるメンズジャケット。着心地も抜群。", price: 19800 },
    { name: "小説：鏡の迷宮", image: "mm.png", category_id: 4, code: "BK-009", stock: 70, description: "古い洋館で起こる連続殺人事件。被害者たちは皆、鏡の前で奇妙な姿で発見される。探偵は鏡に隠された秘密と、迷宮のように複雑に絡み合った人間関係に挑む。鏡に映る真実とは？", price: 980 },
    { name: "漫画：迷子ペット交差点 1巻", image: "pc1.png", category_id: 4, code: "BK-010", stock: 100, description: "人語を話すペットたちが集まる不思議な交差点。そこでペット探偵をしている少女・マルの周りで起こる騒動を描く、ハートフルコメディ。個性豊かなペットたちの日常と、飼い主との絆を描く。", price: 480 },
    { name: "人生ゲーム", image: "lg.png", category_id: 5, code: "EN-002", stock: 50, description: "家族みんなで楽しめる定番のボードゲーム。人生の様々なイベントを体験。", price: 3980 },
    { name: "トランプ", image: "cp.png", category_id: 5, code: "EN-003", stock: 200, description: "定番のトランプ。様々なゲームで楽しめます。", price: 500 },
    { name: "ノートパソコン", image: "lp.png", category_id: 6, code: "PC-003", stock: 40, description: "持ち運びに便利なノートパソコン。ビジネスやプライベートに最適。", price: 98000 },
    { name: "プリンター", image: "pt.png", category_id: 6, code: "PC-004", stock: 60, description: "子供の創造力を育むブロック。様々な形を作って遊べます。カラフルなブロックは子供たちの好奇心を刺激し、集中力や色彩感覚を養います。安全な素材を使用しているので、小さなお子様でも安心して遊べます。", price: 19800 },
    { name: "知育玩具 ブロック", image: "bk.png", category_id: 7, code: "TY-005", stock: 120, description: "子供の想像力を育むドールハウス。人形や家具もセットになっています。お人形遊びを通して、子供たちのコミュニケーション能力や社会性を育みます。細部までこだわったデザインで、お部屋のインテリアとしても楽しめます。", price: 3980 },
    { name: "アイシャドウパレット", image: "ea.png", category_id: 8, code: "CM-004", stock: 180, description: "豊富なカラーが揃ったアイシャドウパレット。様々なメイクを楽しめます。", price: 2980 },
    { name: "ドールハウス", image: "dh.png", category_id: 7, code: "TY-008", stock: 40, description: "子供の想像力を育むドールハウス。人形や家具もセットになっています。", price: 7980 },
    { name: "日焼け止め", image: "sd.png", category_id: 8, code: "CM-007", stock: 200, description: "紫外線から肌を守る日焼け止め。SPF50+ PA++++の高いUVカット効果で、強い日差しから肌をしっかりと守ります。ウォータープルーフタイプで、汗や水に強く、レジャーシーンにも最適です。肌に優しい成分で、敏感肌の方でもご使用いただけます。", price: 1800 },
    { name: "ヨガパンツ", image: "yp.png", category_id: 9, code: "SP-006", stock: 90, description: "ヨガやトレーニングに最適なヨガパンツ。ストレッチ素材で動きやすい。", price: 5980 },
    { name: "ラグ", image: "rg.png", category_id: 10, code: "IN-006", stock: 50, description: "お部屋の印象を変えるラグ。様々なサイズとデザインがあります。お部屋の雰囲気に合わせて選べる豊富なバリエーションをご用意しています。心地よい肌触りで、リラックス空間を演出します。防ダニ加工が施されているので、清潔にお使いいただけます。", price: 12800 },
    { name: "バイオリン", image: "vn.png", category_id: 11, code: "MG-005", stock: 20, description: "美しい音色が特徴のバイオリン。初心者向けセットもあります。", price: 49800 },
    { name: "オートバイ", image: "mb.png", category_id: 12, code: "MC-005", stock: 10, description: "ツーリングに最適なオートバイ。快適な乗り心地とパワフルな走行性能。長距離ツーリングでも疲れにくい設計で、快適なライディングを楽しめます。洗練されたデザインで、街乗りでも注目を集めます。", price: 598000 },
    { name: "DVD 映画「時間遡行遊撃隊クロノス」", image: "jy.png", category_id: 4, code: "BK-011", stock: 50, description: "時間犯罪が多発する未来。歴史改変を目論む犯罪者たちに対抗するため、時間遡行遊撃隊「クロノス」が結成された。主人公の隊員・アレンは、過去に遡り、犯罪を未然に防ぐ任務を遂行する。しかし、ある任務で過去に干渉したことで、歴史が大きく改変されてしまう。アレンは元の歴史に戻すため、時間との壮絶な戦いを繰り広げる。時間遡行の paradox と、歴史の重みを描く、タイムリープアクション。。", price: 1980 },
    { name: "沈黙の海底都市(Blu-ray 通常盤)", image: "ck.png", category_id: 4, code: "BK-012", stock: 70, description: "海底に建設された巨大な実験都市。そこでは、人類の未来を担う革新的なエネルギー研究が行われていた。しかし、ある日、原因不明の事故が発生し、都市は外部との通信を完全に断絶してしまう。都市内に取り残された人々は、次々と襲い来る異形の生物に恐怖する。主人公の技術者・ケンは、生き残った人々を率いて脱出を試みるが、都市には想像を絶する危険が潜んでいた。果たして彼らは海底都市から生還できるのか？絶望的な状況下で繰り広げられる、極限のサバイバルを描くパニック映画。", price: 2980 },
    { name: "魔法の旋律が響く街[DVD]", image: "mk.png", category_id: 4, code: "BK-013", stock: 80, description: "音楽が力を持つ世界。主人公の少女・リリアは、魔法の旋律を奏でることができる特別な力を持っていた。彼女は、音楽学校で学びながら、自分の力をコントロールし、他の人々にも音楽の素晴らしさを伝えていく。しかし、ある日、リリアの力を狙う悪の組織が彼女を狙い始める。リリアは、自分の力を使いこなし、友人たちと共に悪と戦うことになる。音楽と魔法が交差するファンタジー映画。", price: 1980 },
    { name: "天然青汁国産大麦若葉100%", image: "aj.png", category_id: 8, code: "FD-001", stock: 100, description: "国産大麦若葉100%の天然青汁。飲みやすい粉末タイプで、毎日の健康習慣に最適です。栄養豊富な大麦若葉が、美容や健康をサポートします。", price: 1980 },
    { name: "サプリメント（ビタミンC）", image: "vc.png", category_id: 8, code: "FD-002", stock: 150, description: "ビタミンCを配合したサプリメント。毎日の健康維持におすすめです。", price: 980 },
    { name: "頭痛薬", image: "hd.png", category_id: 8, code: "FD-003", stock: 200, description: "頭痛や腰痛に効果的な頭痛薬。効果が早く持続するので、急な痛みにも対応可能です。", price: 500 },
    { name: "血圧計", image: "blp.png", category_id: 8, code: "FD-004", stock: 80, description: "簡単に血圧を測定できる血圧計。正確な測定結果を提供し、健康管理に役立ちます。", price: 1980 },
]

items.each do |item_data|
  item = Item.find_or_create_by!(name: item_data[:name]) do |item|
    item.user_id = rand(1..3)
    item.category_id = item_data[:category_id]
    item.code = item_data[:code]
    item.stock = item_data[:stock]
    item.description = item_data[:description]
    item.new = true
    item.status = 0
    item.price = item_data[:price]
  end

  filename = item_data[:image] # 各商品に対応するファイル名
  path = Rails.root.join("db", "seeds", "development","img", filename) # 画像ファイルのパス

  if File.exist?(path) # ファイルが存在する場合のみ添付
    File.open(path) do |f|
      item.item_picture.attach(io: f, filename: filename)
    end
  else
    puts "Image file not found: #{path}" # ファイルが見つからない場合は警告を表示
  end
end

puts "Seed data created successfully!"