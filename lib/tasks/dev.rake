namespace :dev do
  desc "Configura o ambiente de desenvovimento"
  task setup: :environment do
    if Rails.env.development?

      show_spinner("Apagando Banco de dados"){ %x(rails db:drop)}
      show_spinner("Criando Banco de dados"){ %x(rails db:create)}
      show_spinner("migrando Banco de dados"){ %x(rails db:migrate)}
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)
      
    else
        puts "você não está em ambiente de desenvolvimento"
    end
  end
  
  desc "Cadastra moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas") do

  coins =  [
              { 
                  description: "Bitcoin",
                  acronym: "BTC",
                  url_image: "https://logosmarcas.net/wp-content/uploads/2020/08/Bitcoin-Logo.png",
                  mining_type: MiningType.find_by(acronym: 'PoW')

              },
  
              { 
                  description: "Ethereum",
                  acronym: "ETH",
                  url_image: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/ETHEREUM-YOUTUBE-PROFILE-PIC.png/600px-ETHEREUM-YOUTUBE-PROFILE-PIC.png",
                  mining_type: MiningType.all.sample

              },
  
              { 
                  description: "Iota",
                  acronym: "IOT",
                  url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/1720.png",
                  mining_type: MiningType.all.sample

              },
  
              { 
                  description: "ZCash",
                  acronym: "ZEC",
                  url_image: "https://assets.coingecko.com/coins/images/486/large/circle-zcash-color.png?1547034197",
                  mining_type: MiningType.all.sample

              },
  
              { 
                  description: "Dash",
                  acronym: "DASH",
                  url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/131.png",
                  mining_type: MiningType.all.sample

              }
          ]
      coins.each do |coin|
      sleep(2)
      Coin.find_or_create_by!(coin)
    end
  end
end

desc "Cadastra os de tipos de mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando tipos de mineração") do
    mining_types = [
      {description: "Proof of work", acronym:"PoW"},
      {description: "Proof of Stake", acronym:"PoS"},
      {description: "Proof of Capacity", acronym:"PoC"}
    ]
    mining_types.each do |mining_type|
      sleep(2)
      MiningType.find_or_create_by!(mining_type)
  end
end
 
  end

 private
  def show_spinner(msg_start,msg_end = "Sucesso")
      spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
      spinner.auto_spin
      yield
      spinner.success("(#{msg_end})")
  end

end
