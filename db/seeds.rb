# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Admin.create(name: 'admin', email: 'admin@foo.bar',
             password: 'password', password_confirmation: 'password')

Card.create(name: "宝玉", dept: "怡红院", card_type: "学生")
Card.create(name: "黛玉", dept: "潇湘馆", card_type: "学生")
Card.create(name: "宝钗", dept: "蘅芜苑", card_type: "学生")

Book.create(isbn: 9787100000505, title: "苏鲁支语录", category: "哲学",
            publisher: "商务印书馆", author: "[德]尼采 著 徐梵澄 译",
            year: 2010, price: 27.00, total_storage: 2, storage: 0)
Book.create(isbn: 9787532751464, title: "都柏林人", category: "文学",
            publisher: "上海译文出版社", author: "[爱尔兰]詹姆斯·乔伊斯 著 王逢振 译",
            year: 2010, price: 26.00, total_storage: 3, storage: 2)
Book.create(isbn: 9787562115915, title: "五灯会元", category: "文学",
            publisher: "西南师范大学出版社", author: "(宋)释普济",
            year: 2005, price: 68.00, total_storage: 1, storage: 0)
Book.create(isbn: 10, title: "test", category: "test",
            publisher: "Test Publiser", author: "Test Author",
            year: 2015, price: 25.00, total_storage: 1, storage: 1)

Record.create(card_id: 1, book_id: 1, admin_id: 1)
Record.create(card_id: 1, book_id: 2, admin_id: 1)
Record.create(card_id: 2, book_id: 1, admin_id: 1)
Record.create(card_id: 2, book_id: 3, admin_id: 1)
