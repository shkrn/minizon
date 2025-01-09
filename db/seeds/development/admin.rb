5.times do |i|
    Admin.create!(
        full_name: "管理者#{i + 1}号",
        family_name: "管理者",
        given_name: "#{i + 1}号",
        email: "admin#{i + 1}@example.com",
        password: "minizon!",
        password_confirmation: "minizon!",
        address: "東京都新宿区#{i}-#{i}-#{i}",
        phonenumber: "0901111#{i}#{i}#{i}",
    )
end