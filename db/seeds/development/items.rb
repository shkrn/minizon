items = ["item1", "item2", "item3", "item4", "item5", "item6", "item7", "item8", "item9", "item10"]

items.each_with_index do |i, index|
    Item.create!(
        user_id: 2,
        category_id: 1,
        name: i,
        code: index + 1,
        stock: 100,
        description: "this is description",
        new: true,
        status: 1,
        price: 1000
    )
end