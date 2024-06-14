class Patient < ApplicationRecord

  scope :search, -> (query) {
    where("name LIKE ? OR email LIKE ? OR phone LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
  }
end
