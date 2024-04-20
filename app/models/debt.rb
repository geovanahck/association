class Debt < ApplicationRecord
  belongs_to :person

  validates :amount, presence: true

  def update_cache_balance
    person.update_cache_balance(-amount)
  end

end
