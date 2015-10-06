class Customer

  def initialize
    @placed = false
    @received_text = false
  end

  def placed?
    @placed
  end

  def affirmative
    @placed = true
  end

  def received_text?
    @received_text
  end

  def text_received
    @received_text = true
  end
end
