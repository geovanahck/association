class DashboardService
    def initialize(current_user)
      @current_user = current_user
    end
  
    def active_people_pie_chart
      Rails.cache.fetch("active_people_pie_chart", expires_in: 1.hour) do
        {
          active: Person.where(active: true).count,
          inactive: Person.where(active: false).count
        }
      end
    end
  
    def total_debts
      Rails.cache.fetch("total_debts", expires_in: 1.hour) do
        active_people_ids = Person.where(active: true).select(:id)
        Debt.where(person_id: active_people_ids).sum(:amount)
      end
    end
  
    def total_payments
      Rails.cache.fetch("total_payments", expires_in: 1.hour) do
        active_people_ids = Person.where(active: true).select(:id)
        Payment.where(person_id: active_people_ids).sum(:amount)
      end
    end
  
    def amount
      Rails.cache.fetch("amount", expires_in: 1.hour) do
        Person.where(active: true).sum(:amount)
      end
    end
  
    def last_debts
      Rails.cache.fetch("last_debts", expires_in: 1.hour) do
        Debt.order(created_at: :desc).limit(10).pluck(:id, :amount)
      end
    end
  
    def last_payments
      Rails.cache.fetch("last_payments", expires_in: 1.hour) do
        Payment.order(created_at: :desc).limit(10).pluck(:id, :amount)
      end
    end
  
    def my_people
      Rails.cache.fetch("my_people_#{cache_key_user}", expires_in: 1.hour) do
        Person.where(user: @current_user).order(:created_at).limit(12)
      end
    end
  
    def top_person
        Rails.cache.fetch("top_person", expires_in: 1.hour) do
          Person.all.max_by(&:amount)
        end
      end
  
    def bottom_person
        Rails.cache.fetch("bottom_person", expires_in: 1.hour) do
          Person.all.min_by(&:amount)
        end
      end
  
    def last_large_debts
        Rails.cache.fetch("last_large_debts", expires_in: 1.hour) do
          Debt.includes(:person)
              .where("amount > 100000")
              .order(created_at: :desc)
              .limit(8)
        end
      end
      
    private
  
    def cache_key_user
      @current_user.id
    end
  end
  