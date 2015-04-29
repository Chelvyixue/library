class Record < ActiveRecord::Base
  belongs_to :book
  belongs_to :card
  belongs_to :admin
  validates :book_id, presence: true
  validates :card_id, presence: true
  validates :admin_id, presence: true

  before_create do
    self.to_return_at = self.created_at + 30.days
  end
end
