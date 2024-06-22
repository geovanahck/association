class Person < ApplicationRecord
  belongs_to :user, optional: true

  has_many :debts, dependent: :destroy
  has_many :payments, dependent: :destroy

  validates :name, :national_id, presence: true
  validates :national_id, uniqueness: true
  validate :cpf_or_cnpj

  # TODO: refactor me
  #
  # - improve performance using SQL
  # - sum payments
  # - rename to "balance"

def balance_cache
  Rails.cache.fetch("#{id}/balance", expires_in: 30.minutes ) do
    payments.sum(:amount) - debts.sum(:amount)
  end
end

def update_cache_balance(amount)
  new_balance = balance_cache()+ amount
  Rails.cache.write("#{id}/balance", new_balance)
end

require 'csv'

def self.to_excel
  attributes = %w{ name balance_cache}
  CSV.generate(headers:true) do |csv|
    csv << attributes
      order(:name).each do |person|
      csv << attributes.map{ |attr| person.send(attr) }
    end
  end
end

  private

  def cpf_or_cnpj
    if !CPF.valid?(national_id) && !CNPJ.valid?(national_id)
      errors.add :national_id, :invalid
    end
  end
end

