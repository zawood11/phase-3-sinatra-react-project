puts "🌱 Seeding data..."

Portfolio.destroy_all
Position.destroy_all
Price.destroy_all
Stock.destroy_all


# Seed your database here

#Starter Portfolios
portfolio1 = Portfolio.create(portfolio_name: "Well Rounded Portfolio")
portfolio2 = Portfolio.create(portfolio_name: "Super Selective Portfolio")

#Starter Positions
Position.create(portfolio_id: portfolio1[:id], symbol: "AAPL")
Position.create(portfolio_id: portfolio1[:id], symbol: "AMZN")
Position.create(portfolio_id: portfolio1[:id], symbol: "TSLA")
Position.create(portfolio_id: portfolio2[:id], symbol: "AAPL")
Position.create(portfolio_id: portfolio2[:id], symbol: "TSLA")

#Starter Stocks
Stock.create(symbol: "AAPL", name: "Apple Inc", description: "Apple Inc. is an American multinational technology company that specializes in consumer electronics, computer software, and online services. Apple is the world's largest technology company by revenue (totalling $274.5 billion in 2020) and, since January 2021, the world's most valuable company. As of 2021, Apple is the world's fourth-largest PC vendor by unit sales, and fourth-largest smartphone manufacturer. It is one of the Big Five American information technology companies, along with Amazon, Google, Microsoft, and Facebook.")
Stock.create(symbol: "AMZN", name: "Amazon.com Inc", description: "Amazon.com, Inc. is an American multinational technology company which focuses on e-commerce, cloud computing, digital streaming, and artificial intelligence. It is one of the Big Five companies in the U.S. information technology industry, along with Google, Apple, Microsoft, and Facebook. The company has been referred to as one of the most influential economic and cultural forces in the world, as well as the world's most valuable brand.")
Stock.create(symbol: "TSLA", name: "Tesla Inc", description: "Tesla, Inc. is an American electric vehicle and clean energy company based in Palo Alto, California. Tesla's current products include electric cars, battery energy storage from home to grid-scale, solar panels and solar roof tiles, as well as other related products and services. In 2020, Tesla had the highest sales in the plug-in and battery electric passenger car segments, capturing 16% of the plug-in market (which includes plug-in hybrids) and 23% of the battery-electric (purely electric) market. Through its subsidiary Tesla Energy, the company develops and is a major installer of solar photovoltaic energy generation systems in the United States. Tesla Energy is also one of the largest global suppliers of battery energy storage systems, with 3 GWh of battery storage supplied in 2020.")

#Sample Tickers to start with...(facilitating price data API call through AlphaVantage)
symbols = ["AAPL", "AMZN", "TSLA"]

#Call to Alpha Advantage for each ticker (Last 100 days of price history)
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
