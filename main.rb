require_relative "cambio"
require_relative "cashier"

  def menu
    puts '################################'
    puts '## [1] Comprar dólares        ##'
    puts '## [2] Vender dólares         ##'
    puts '## [3] Comprar reais          ##'
    puts '## [4] Vender reias           ##'
    puts '## [5] Ver operações do dia   ##'
    puts '## [6] Ver situação do caixa  ##'
    puts '## [7] Sair                   ##'
    puts '################################'
    print 'Escolha uma das opções acima: '
    option = gets.to_i
  end

  cashier = Cashier.new
  option = menu
  
  while option != 7 do
    if option == 1
      cashier.buy_dollar
    elsif option == 2
      cashier.sale_dollar
    elsif option == 3
      cashier.buy_real  
    elsif option == 4
      cashier.sale_real  
    elsif option == 5
      cashier.register
    elsif option == 6
      cashier.caixa
    else
      puts 'Digite um número valido: '
    end
    option = menu
  end
  puts '######  Até logo!!!  #######'