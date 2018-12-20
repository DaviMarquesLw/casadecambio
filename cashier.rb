require_relative 'cambio'
require_relative 'sqlite3'

class Cashier

    attr_accessor :available_dolar, :available_real, :dolar_price, :caixa, :buy_dollar, :sale_dollar, :buy_real, :sale_real, :transactions, :transactions_cancel

    def initialize
        puts '****** Olá, sistema no ar ******'
        puts
        puts 'Digite a quantidade de dólares disponíveis: '
        @available_dolar = gets.to_f
        puts
        puts 'Digite a quantidade de reais disponíveis: '
        @available_real = gets.to_f
        puts
        puts 'Digite a cotação do dolar atual: '
        @dolar_price  = gets.to_f
        puts
        @transactions = []
        @transactions_cancel = []
    end

    transaction = 0
    
    def caixa
      puts "Situação do caixa em dolar $#{ self.available_dolar }"
      puts "Sitação do caixa em reais R$#{ self.available_real }"
    end

    def buy_dollar
      c = Cambio.new(type_dolar = 'Dolar', type_real = 'Real', type_sale = 'Venda', type_buy = 'Compra')
      puts 'Digite a quantidade de dólares que deseja comprar: '
      c.buy_qtd_dolar = gets.to_f
      transaction = dolar_price * c.buy_qtd_dolar
          if  transaction <= available_real
            puts "certeza que gostaria de comprar $ #{ c.buy_qtd_dolar } dolares? Digite [1] sim ou [2] nao"
            choice = gets.chomp
              if choice == '1'
                self.available_real -= transaction
                self.available_dolar += c.buy_qtd_dolar
                transactions << { valor: c.buy_qtd_dolar, tipo: c.type_sale, moeda: c.type_dolar, preco: dolar_price }
                puts "compra efetuada no valor de $ #{ c.buy_qtd_dolar } dolares."
              elsif choice == '2'
                puts 'Compra cancelada'
                transactions_cancel << { valor: c.buy_qtd_dolar, tipo: c.type_sale, moeda: c.type_dolar, preco: dolar_price }
              else
                puts 'Opção inválida!'
              end
          else
            puts 'quantidade solicitada maior do que a existente.'
          end
    end

    def sale_dollar
      c = Cambio.new(type_dolar = 'Dolar', type_real = 'Real', type_sale = 'Venda', type_buy = 'Compra')
      puts 'Digite a quantidade de dólares que deseja vender: '
      c.sale_qtd_dolar = gets.to_f
      transaction = dolar_price * c.sale_qtd_dolar
      if transaction <= available_real
        puts "certeza que gostaria de vender $ #{ c.sale_qtd_dolar } dolares? Digite [1] sim ou [2] nao"
        choice = gets.chomp
        if choice == '1'
          self.available_real += transaction
          self.available_dolar -= c.sale_qtd_dolar
          transactions << { valor: c.sale_qtd_dolar, tipo: c.type_sale, moeda: c.type_dolar, preco: dolar_price }
          puts "compra efetuada no value de $ #{ c.sale_qtd_dolar } dolares."
        elsif choice == '2'
          puts 'Compra cancelada'
          transactions_cancel << { valor: c.sale_qtd_dolar, tipo: c.type_sale, moeda: c.type_dolar, preco: dolar_price }
        else
          puts 'Opção inválida!'
        end
      else
        puts 'quantidade solicitada maior do que a existente.'
      end
    end

    def buy_real
      c = Cambio.new(type_dolar = 'Dolar', type_real = 'Real', type_sale = 'Venda', type_buy = 'Compra')
      puts 'Digite quantos reais gostaria de comprar: '
      c.buy_qtd_real = gets.to_f
      transaction = c.buy_qtd_real / dolar_price
        if c.buy_qtd_real <= available_dolar    
          puts "certeza que gostaria de comprar R$ #{ c.buy_qtd_real } reais? Digite [1] sim ou [2] nao"
          choice = gets.chomp
          if choice == '1'
            self.available_dolar -= transaction
            self.available_real += c.buy_qtd_real
            transactions << { valor: c.buy_qtd_real, tipo: c.type_sale, moeda: c.type_dolar, preco: dolar_price }
            puts "compra efetuada no value de R$ #{ c.buy_qtd_real } reais."
          elsif choice == '2'
            puts 'Compra cancelada'
            transactions_cancel << { valor: c.buy_qtd_real, tipo: c.type_sale, moeda: c.type_dolar, preco: dolar_price }
          else
            puts 'Opção inválida!'
          end
        else
          puts 'quantidade solicitada maior do que a existente.'
        end
    end

    def sale_real
      c = Cambio.new(type_dolar = 'Dolar', type_real = 'Real', type_sale = 'Venda', type_buy = 'Compra')
      puts 'Digite a quantidade de reais que gostaria de vender: '
      c.sale_qtd_real = gets.to_f
      transaction = c.sale_qtd_real / dolar_price
        if  c.sale_qtd_real <= available_real
          puts "certeza que gostaria de vender R$#{ c.sale_qtd_real } reais? Digite [1] sim ou [2] nao"
          choice = gets.chomp
            if choice == '1'
              self.available_dolar += transaction
              self.available_real -= c.sale_qtd_real
              transactions << { valor: c.sale_qtd_real, tipo: c.type_sale, moeda: c.type_dolar, preco: dolar_price }
              puts "compra efetuada no value de $ #{ c.sale_qtd_real } dolares."
            elsif choice == '2'
              puts 'Compra cancelada'
              transactions_cancel << { valor: c.sale_qtd_real, tipo: c.type_sale, moeda: c.type_dolar, preco: dolar_price }
            else
              puts 'Opção inválida!'
            end
        else
          puts 'quantidade solicitada maior do que a existente.'
        end    
    end

    def register
      puts '###### Operacoes do dia: ######'
      puts 'Compras aprovadas: '
      transactions.each_with_index do |task, number, price|
      puts "#{number + 1}#{task}"
      end
      puts 'Compras canceladas: '
      transactions_cancel.each_with_index do |task, number, price|
      puts "#{number + 1}#{task}"
      end
    end
  

end