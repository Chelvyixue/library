class Record < ActiveRecord::Base
  belongs_to :book
  belongs_to :card
  belongs_to :admin
  validates :book_id, presence: true
  validates :card_id, presence: true
  validates :admin_id, presence: true
end
