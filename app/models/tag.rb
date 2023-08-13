class Tag < ApplicationRecord
    has_many :book_tags, dependent: :destroy
    has_many :books, through: :book_tags

    validates :name, presence: true

    before_destroy :check_books

    private
    def check_books
        return false if books.any?
    end
end
