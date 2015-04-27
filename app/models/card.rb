# coding: utf-8
class Card < ActiveRecord::Base
  validates :name, presence: true
  validates :dept, presence: true
  validates :card_type, presence: true, inclusion: { in: %w(学生 老师) }
end
