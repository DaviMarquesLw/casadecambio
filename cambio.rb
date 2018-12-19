class Cambio

  attr_accessor :sale_qtd_dolar, :buy_qtd_dolar, :sale_qtd_real, :buy_qtd_real, :type_buy, :type_dolar, :type_real, :type_sale
  
  def initialize(type_dolar = 'Dolar', type_real = 'Real', type_sale = 'Venda', type_buy = 'Compra')
    @sale_qtd_dolar = []
    @buy_qtd_dolar = []
    @sale_qtd_real = []
    @buy_qtd_real = []
    @type_dolar = type_dolar
    @type_real = type_real
    @type_sale = type_sale
    @type_buy = type_buy
  end
  
end