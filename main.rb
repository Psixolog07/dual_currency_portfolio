require_relative "lib/portfolio"

begin
  exchange_rate = Portfolio.get_exchange_rate
rescue SocketError
  puts "Какая-то ошибка с соединением, пожалуйста введите курс самостоятельно"
  exchange_rate = gets.to_f
end

puts "Текущий курс: #{exchange_rate}"
puts "Сколько у Вас рублей? (с точностью до копеек)"
rubles_amount = gets.to_f
puts "Сколько у Вас долларов? (с точностью до центов)"
dollars_amount = gets.to_f

difference = Portfolio.get_difference(exchange_rate, rubles_amount, dollars_amount)
puts Portfolio.what_to_do_with_money(difference, exchange_rate)
