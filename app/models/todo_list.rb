class TodoList < ApplicationRecord
  has_many :todo_items
  validates :title, presence: true, length: {minimum: 3}
  validates :body, presence: true, length: {minimum: 5}
end
