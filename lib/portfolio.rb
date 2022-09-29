require "uri"
require "net/http"
require "rexml/document"

module Portfolio
  module_function

  def what_to_do_with_money(difference, exchange_rate)
    if difference.abs / 2 < 0.01 * exchange_rate
      "Портфель сбалансирован"
    elsif difference > 0
      "Поменяйте #{((difference / 2).round(2))} рублей"
    else
      "Поменяйте #{((difference.abs / 2 / exchange_rate).round(2))} долларов"
    end
  end

  def get_difference(exchange_rate, rubles_amount, dollars_amount)
    rubles_amount - dollars_amount * exchange_rate
  end

  def get_exchange_rate
    uri = URI.parse("http://www.cbr.ru/scripts/XML_daily.asp")
    response = Net::HTTP.get_response(uri)
    doc = REXML::Document.new(response.body)
    doc.root.elements["Valute[@ID = 'R01235']/Value"].text.sub(',', '.').to_f
  end
end
