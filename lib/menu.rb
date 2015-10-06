module Menu

  def menu
    @dishes.each do |dish, price|
      puts "#{dish}, $#{price}"
    end
  end
end
