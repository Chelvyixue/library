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
