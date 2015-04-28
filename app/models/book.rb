class Book < ActiveRecord::Base
  has_many :records, dependent: :destroy

  default_scope -> { order(title: :asc) }
  validates :isbn, presence: true, uniqueness: true
  validates :category, presence: true
  validates :title, presence: true
  validates :publisher, presence: true
  validates :year, presence: true
  validates :author, presence: true
  validates :price, presence: true
  validates :storage, presence: true

  def increase_by(n)
    n = n.to_i
    if n > 0
      new_storage = storage + n
      new_total_storage = total_storage + n
      update(storage: new_storage, total_storage: new_total_storage)
      true
    else
      false
    end
  end

  def borrow_book
    if storage > 0
      update(storage: storage - 1)
      true
    end
  end

  def return_book(card_id)
    book_id = id
    record = Record.where("book_id = :book_id AND card_id = :card_id AND returned_at IS NULL", book_id: book_id, card_id: card_id).order("created_at DESC").first
    if record
      record.update(returned_at: DateTime.now)
      update(storage: storage + 1)
      true
    end
  end
end
