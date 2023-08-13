class BookUser < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validate :issued_before

  private
  def issued_before
    if user.issued_books.include?(book)
      errors.add(:base, "same book can't be issued")
    end
  end
end
