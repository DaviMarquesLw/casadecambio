require_relative "cambio"

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
    puts
    print 'Escolha uma das opções acima: '
    option = gets.to_i
  end

  c = Cambio.new(type_dolar = 'Dolar', type_real = 'Real', type_sale = 'Venda', type_buy = 'Compra')

  puts '****** Olá, sistema no ar ******'
  puts
  puts 'Digite a quantidade de dólares disponíveis: '
  available_dolar = gets.to_f
  puts
  puts 'Digite a quantidade de reais disponíveis: '
  available_real = gets.to_f
  puts
  puts 'Digite a cotação do dolar atual: '
  dolar_price  = gets.to_f
  puts

  option = menu
  real = 1
  approved_result = []
  reapproved_result = []
  transaction = 0

  while option != 7 do
    if option == 1
      puts 'Digite a quantidade de dólares que deseja comprar: '
      c.buy_qtd_dolar = gets.to_f
      transaction = dolar_price * c.buy_qtd_dolar
        if  transaction <= available_real
          puts "certeza que gostaria de comprar $ #{ c.buy_qtd_dolar } dolares? Digite [1] sim ou [2] nao"
          choice = gets.chomp
            if choice == '1'
              available_real = available_real - transaction
              available_dolar = available_dolar + c.buy_qtd_dolar
              approved_result << { value: c.buy_qtd_dolar, type: c.type_buy, coin: c.type_dolar, price: dolar_price }
              puts "compra efetuada no valor de $ #{ c.buy_qtd_dolar } dolares."
            elsif choice == '2'
              puts 'Compra cancelada'
              reapproved_result << { value: c.buy_qtd_dolar, type: c.type_buy, coin: c.type_dolar, price: dolar_price }
            else
              puts 'Opção inválida!'
            end
        else
          puts 'quantidade solicitada maior do que a existente.'
        end
    elsif option == 2
      puts 'Digite a quantidade de dólares que deseja vender: '
      c.sale_qtd_dolar = gets.to_f
      transaction = dolar_price * c.sale_qtd_dolar
      if transaction <= available_real
        puts "certeza que gostaria de vender $ #{ c.sale_qtd_dolar } dolares? Digite [1] sim ou [2] nao"
        choice = gets.chomp
        if choice == '1'
          available_real = available_real + transaction
          available_dolar = available_dolar - c.sale_qtd_dolar
          approved_result << { value: c.sale_qtd_dolar, type: c.type_sale, coin: c.type_dolar, price: dolar_price }
          puts "compra efetuada no value de $ #{ c.sale_qtd_dolar } dolares."
        elsif choice == '2'
          puts 'Compra cancelada'
          reapproved_result << { value: c.sale_qtd_dolar, type: c.type_sale, coin: c.type_dolar, price: dolar_price }
        else
          puts 'Opção inválida!'
        end
      else
        puts 'quantidade solicitada maior do que a existente.'
      end
    elsif option == 3
      puts 'Digite quantos reais gostaria de comprar: '
      c.buy_qtd_real = gets.to_f
      transaction = c.buy_qtd_real / dolar_price
        if c.buy_qtd_real <= available_dolar    
          puts "certeza que gostaria de comprar R$ #{ c.buy_qtd_real } reais? Digite [1] sim ou [2] nao"
          choice = gets.chomp
          if choice == '1'
            available_dolar = available_dolar - transaction
            available_real = available_real + c.buy_qtd_real
            approved_result << { value: c.buy_qtd_real, type: c.type_buy, coin: c.type_real, price: dolar_price }
            puts "compra efetuada no value de R$ #{ c.buy_qtd_real } reais."
          elsif choice == '2'
            puts 'Compra cancelada'
            reapproved_result << { value: c.buy_qtd_real, type: c.type_buy, coin: c.type_real, price: dolar_price }
          else
            puts 'Opção inválida!'
          end
        else
          puts 'quantidade solicitada maior do que a existente.'
        end
    elsif option == 4
      puts 'Digite a quantidade de reais que gostaria de vender: '
      c.sale_qtd_real = gets.to_f
      transaction = c.sale_qtd_real / dolar_price
        if  c.sale_qtd_real <= available_real
          puts "certeza que gostaria de vender R$#{ c.sale_qtd_real } reais? Digite [1] sim ou [2] nao"
          choice = gets.chomp
            if choice == '1'
              available_dolar = available_dolar + transaction
              available_real = available_real - c.sale_qtd_real
              approved_result << { value: c.sale_qtd_dolar, type: c.type_sale, coin: c.type_dolar, price: dolar_price }
              puts "compra efetuada no value de $ #{ c.sale_qtd_real } dolares."
            elsif choice == '2'
              puts 'Compra cancelada'
              reapproved_result << { value: c.sale_qtd_dolar, type: c.type_sale, coin: c.type_dolar, price: dolar_price }
            else
              puts 'Opção inválida!'
            end
        else
          puts 'quantidade solicitada maior do que a existente.'
        end
    elsif option == 5
      puts
      puts '###### Operacoes do dia: ######'
      puts
      puts 'Compras aprovadas: '
      approved_result.each_with_index do |task, number, price|
      puts "#{number + 1}#{task}"
      end
      puts
      puts 'Lista de compras reprovadas: '
      reapproved_result.each_with_index do |task, number|
      puts "#{number + 1} #{task}"
      end
    elsif option == 6
      puts "Situação do caixa em dolar $#{ available_dolar }"
      puts "Sitação do caixa em reais R$#{ available_real }"
    else
      puts 'Digite um número valido: '
    end
    option = menu
  end
  puts
  puts '######  Até logo!!!  #######'
  puts