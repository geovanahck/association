class Payment < ApplicationRecord
  belongs_to :person

  after_create :update_cache_balance

  def update_cache_balance
    person.update_cache_balance(amount)
  end
  
end


