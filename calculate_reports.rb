#!/usr/bin/env ruby

# frozen_string_literal: true

require 'json'

require_relative 'expense_reports.rb'
p "#{ExpenseReports.calculate(JSON.parse(*ARGV))}$"
