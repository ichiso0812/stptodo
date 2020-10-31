class Project < ApplicationRecord
  #todo
  #has_many :todo_lists, dependant: :destroy
  belongs_to :user

  validates :name, presence: true
end
