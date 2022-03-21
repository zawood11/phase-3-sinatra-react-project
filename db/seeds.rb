puts "🌱 Seeding data..."

Price.destroy_all

# Seed your database here
symbols = ["AAPL", "AMZN", "TSLA"]

symbols.each do |symbol|
    response = RestClient.get "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=#{symbol}&apikey=LOOC2YV5NOI7NALE"

    symbol_hash = JSON.parse(response)

    symbol_hash["Time Series (Daily)"].each do |date, info|

        Price.create(
            symbol: symbol_hash["Meta Data"]["2. Symbol"],
            date: date,
            open: info["1. open"],
            high: info["2. high"],
            low: info["3. low"],
            close: info["4. close"],
            volume: info["5. volume"]
        )
    end

end

puts "✅ Done seeding!"
