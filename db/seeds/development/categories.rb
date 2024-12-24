category = ["電化製品", "生活用品・キッチン用品", "ファッション", "書籍", "エンターテイメント", "文房具・オフィス用品", "スポーツ・アウトドア","インテリア","コスメ・健康・医薬品"]

category.each do |name|
      Category.create!(
        category_name: name
      )
end