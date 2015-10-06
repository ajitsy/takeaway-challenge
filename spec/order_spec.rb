require 'order'
require 'menu'
require 'customer'

describe Order do


  describe '#menu' do
    it{is_expected.to respond_to(:menu)}
    it 'shows a list of dishes with prices' do
      expect(subject.menu).to include ({'pizza'=>12})
    end
  end

  describe '#select_dish' do
    it{is_expected.to respond_to(:select_dish).with(2).argument}
    it 'selects a dish from a menu' do
      dish = subject.select_dish('pizza', 2)
      expect(subject.selections).not_to be_empty
    end
    it 'raises an error when selection is not valid' do
      expect{subject.select_dish('trash', 3)}.to raise_error 'Selection not valid'
    end
  end
  describe '#breakdown' do
    it 'shows the dish ordered and price based on quantity ordered' do
      subject.select_dish('pizza', 2)
      subject.select_dish('fries', 3)
      expect(subject.breakdown).to include (['pizza', 24])
    end
  end
  describe '#total_price' do
    it 'shows the total price for the order' do
      subject.select_dish('pizza', 2)
      subject.select_dish('fries', 3)
      subject.breakdown
      expect(subject.total_price).to eq (33)
    end
  end
  let(:customer) {double :customer}
  let(:sms_client) {double :sms_client, send_text_message: nil}
    describe '#place_order' do
    it 'raises an error if no dishes selected' do
      expect{subject.place_order(customer, sms_client)}.to raise_error 'No dishes selected'
    end
    it 'allows customer to place order and sends a text message' do
      allow(customer).to receive(:affirmative) {true}
      allow(customer).to receive(:placed?) {true}
      allow(customer).to receive(:text_received) {true}
      subject.select_dish('fries', 3)
      subject.place_order(customer, sms_client)
      expect(customer.placed?).to be true
    end
  end
end
