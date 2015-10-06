

module Twilio
  def self.send_text_message(customer)
    # Get your Account Sid and Auth Token from twilio.com/user/account
  account_sid = ENV['ACCOUNT_SID']
  auth_token = ENV['TWILIO_AUTH_TOKEN']
  @client = Twilio::REST::Client.new account_sid, auth_token

  message = @client.account.messages.create(:body => "Thank you! Your order was placed and will be delivered before #{@time_order}",
      :to => ENV['PHONE_NUMBER'],     # Replace with your phone number
      :from => ENV['TWILIO_NUMBER'])   # Replace with your Twilio number
  puts message.sid
  customer.text_received
  end
end
