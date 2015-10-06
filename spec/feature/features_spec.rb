require 'order'
require 'menu'
require 'customer'

describe 'Features' do

  let(:order) {Order.new}
  let(:customer) {Customer.new}
  describe '#menu' do
    it{expect(order).to respond_to(:menu)}
    it 'displays the menu' do
      expect(order.menu).to include ({'pizza'=>12})
    end
  end
  describe '#select_dish' do
    it{expect(order).to respond_to(:select_dish).with(2).argument}
    it 'selects a dish from a menu' do
      dish = order.select_dish('pizza', 2)
      expect(order.selections).not_to be_empty
    end
    it 'raises an error when selection is not valid' do
      expect{order.select_dish('trash', 3)}.to raise_error 'Selection not valid'
    end
  end
  describe '#breakdown' do
    it 'shows the dish ordered and price based on quantity ordered' do
      order.select_dish('pizza', 2)
      order.select_dish('fries', 3)
      expect(order.breakdown).to include (['pizza', 24])
    end
  end
  describe '#total_price' do
    it 'shows the total price for the order' do
      order.select_dish('pizza', 2)
      order.select_dish('fries', 3)
      order.breakdown
      expect(order.total_price).to eq (33)
    end
  end
  describe '#place_order' do
    let(:sms_client) {double :sms_client, send_text_message: nil}
    it 'raises an error if no dishes selected' do
      expect{order.place_order(customer, sms_client)}.to raise_error 'No dishes selected'
    end
    it 'allows customer to place order and sends a text message' do
      order.select_dish('pizza', 2)
      order.place_order(customer, sms_client)
      expect(customer.placed?).to be true
    end
  end
end
