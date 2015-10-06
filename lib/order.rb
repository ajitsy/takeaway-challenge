require_relative 'menu'
require_relative 'customer'
require_relative 'twilio'
require 'twilio-ruby'


class Order
  include Menu
  

  def initialize
    @dishes = { 'pizza'=> 12, 'fries'=> 3, 'soup'=> 4 }
    @selections = []
    @hashed_selections = {}
  end

  attr_reader :hashed_selections, :selections, :dishes

  def select_dish(dish, quantity)
    fail 'Selection not valid' unless dish == "pizza" || dish == "fries" || dish == "soup"
    selections << [dish, quantity]
    @hashed_selections = Hash[*selections.flatten(1)]
  end

  def breakdown
    @total_price = []
    @price_totals = []

    @hashed_selections.inject(0) do |result, (key, value)|
      val = dishes.fetch(key)
      total_value = val * value
      @total_price << [key, total_value]
      @price_totals << total_value
    end

    @total_price.each do |dish, price|
      puts "#{dish}, $#{price}"
    end
  end

  def total_price
    @price_totals.inject(:+)
  end

  def place_order (customer, sms_client)
    fail 'No dishes selected' if selections.empty?
    @time_order = Time.now + 3600
    sms_client.send_text_message(customer)
    customer.affirmative
  end

end
