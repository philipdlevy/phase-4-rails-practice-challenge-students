class Instructor < ApplicationRecord
    validates :name, presence: true
    # This validates that only letters are used
    validates :name, format: { with: /\A[a-zA-Z]+\z/,
    message: "only allows letters" }

    has_many :students, dependent: :destroy
end
