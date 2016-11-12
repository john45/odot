class TodoItem < ApplicationRecord
  belongs_to :todo_list
  validates :content, presence: true, length: {minimum: 2}
end
