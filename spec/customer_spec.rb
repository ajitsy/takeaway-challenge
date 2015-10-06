require 'customer'

describe Customer do
  it{is_expected.to respond_to(:placed?)}
  it{is_expected.to respond_to(:affirmative)}
  it{is_expected.to respond_to(:received_text?)}
  it{is_expected.to respond_to(:text_received)}

end
