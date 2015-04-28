# coding: utf-8
class Card < ActiveRecord::Base
  has_many :records, dependent: :destroy
  has_many :borrows, -> { where "returned_at IS NULL" },
           through: :records, source: :book, dependent: :destroy

  validates :name, presence: true
  validates :dept, presence: true
  validates :card_type, presence: true, inclusion: { in: %w(学生 教师) }
end
