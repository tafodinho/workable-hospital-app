class Patient < ApplicationRecord

  scope :search, -> (query) {
    where("name ILIKE ? ", "%#{query}%")
  }
end
