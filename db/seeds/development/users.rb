family = ["山田", "佐藤", "鈴木", "田中", "伊藤", "渡辺", "高橋", "山本", "中村", "小林"]
given = ["太郎", "花子", "一郎", "春子", "健一", "次郎", "三郎", "秋子", "夏子", "冬子"]

family_en = ["Yamada", "Sato", "Suzuki", "Tanaka", "Ito", "Watanabe", "Takahashi", "Yamamoto", "Nakamura", "Kobayashi"]


10.times do |i|
    if i == 0 || i == 1 || i == 2
        status_value = 1
    else
        status_value = 0
    end
    User.create!(
        full_name: "#{family[i]} #{given[i]}",
        family_name: family[i],
        given_name: given[i],
        business_name: "#{family[i]}ストア",
        #email: "#{family_en[i].downcase}#{i}@example.com",
        email: "user#{i}@example.com",
        password: "minizon!",
        password_confirmation: "minizon!",
        #password: "pass",
        #password_confirmation: "pass",
        address: "東京都新宿区#{i}-#{i}-#{i}",
        phonenumber: "0901111#{i}#{i}#{i}",
        status: status_value
    )
end