class Book < ApplicationRecord
  belongs_to :user
  
  include AASM

  aasm column: 'status' do
    state :available, initial: true
    state :not_available
    state :archived
  end

  validates :name, presence: true
  validates :description, presence: true
  validates :number_of_copy, presence: true

  has_many :book_tags, dependent: :destroy
  has_many :tags, through: :book_tags

  has_many :book_users
  has_many :students, class_name: "User", through: :book_users, source: :user

  def available_copy
    number_of_copy - book_users.count
  end

  scope :tagged_with, ->(tag_names){
    joins(:tags).where(tags: {name: tag_names}).group('books.id').having("COUNT(tags.id)>=?", tag_names.size)
  }
end
