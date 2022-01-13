# frozen_string_literal: true

class ExpenseReports
  KINDS = %w(meal transportation parking)
  RATES = {
    meal: {
      limit: 3,
      normal_pay: 10,
      reduced_pay: 6
    },
    transportation: {
      limit: 100,
      normal_pay: 0.12,
      reduced_pay: 0.08
    },
    parking: {
      limit: 20,
      normal_pay: 1,
      reduced_pay: 0.5
    }
  }

  def self.calculate(tickets)
    raise 'Invalid concept. Check tickets' if tickets.select { |ticket| !KINDS.include?(ticket.first) }.any?

    refounds = {
        'meal': 0,
        'transportation': 0,
        'parking': 0
    }

    tickets.each do |kind, quantity|
        case kind
        when 'meal'
           refounds[kind.to_sym] = refounds[kind.to_sym] + 1
        else
           refounds[kind.to_sym] = refounds[kind.to_sym] + quantity
        end
    end

    refound = 0
    RATES.keys.each do |kind|
        refound += calculate_single_refound(refounds[kind], RATES[kind][:limit], RATES[kind][:normal_pay], RATES[kind][:reduced_pay])
    end

    refound
  end

  def self.calculate_single_refound(quantity, limit, normal_pay, reduced_pay)
    if quantity >= limit
        reduced_pay * (quantity - limit) + normal_pay * limit
    else
        normal_pay * quantity
    end
  end
end
