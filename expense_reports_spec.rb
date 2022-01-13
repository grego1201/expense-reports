# frozen_string_literal: true

require_relative './expense_reports'

describe ExpenseReports do
  subject {ExpenseReports.calculate(tickets)}

  context 'Errors' do
    let(:tickets) {
      [
        ['foo', 3],
        ['parking', 30]
      ]
    }

    it 'Raise exception with invalid concept' do
      expect {subject}.to raise_error(RuntimeError, 'Invalid concept. Check tickets')
    end
  end

  context 'Valid' do
    let(:transportation_quantity) { 40 }
    let(:transportation_result) { 100 * 0.12 + 100 * 0.08 }
    let(:parking_quantity) { 10 }
    let(:parking_result) { 20 * 1 + 30 * 0.5 }
    let(:meal_quantity) { 1 }
    let(:meal_result) { 3 * 10 + 2 * 6 }
    let(:all_limits_tickets) {
      [
        ['transportation', 75],
        ['meal', 1],
        ['transportation', 15],
        ['meal', 1],
        ['meal', 1],
        ['parking', 15],
        ['transportation', 20],
        ['meal', 1],
        ['parking', 20]
      ]
    }

    let(:all_limits_result) { 76.3 }

    it 'Exceed km limit' do
      tickets = generate_fake_tickets('transportation', transportation_quantity)
      expect(described_class.calculate(tickets)).to eq(transportation_result)
    end

    it 'Exceed parking limit' do
      tickets = generate_fake_tickets('parking', parking_quantity)
      expect(described_class.calculate(tickets)).to eq(parking_result)
    end

    it 'Exceed meal limit' do
      tickets = generate_fake_tickets('meal', meal_quantity)
      expect(described_class.calculate(tickets)).to eq(meal_result)
    end

    it 'Exceed all limits' do
      expect(described_class.calculate(all_limits_tickets)).to eq(all_limits_result)
    end

    def generate_fake_tickets(concept, quantity)
      5.times.map { |_| [concept, quantity]}
    end
  end
end
