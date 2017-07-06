namespace :dev do
  task :fetch_city => :environment do
    puts "Fetch city data..."
    response = RestClient.get "http://v.juhe.cn/weather/citys", :params => { :key => "1a477a118b9908df9b66df7022ad6184" }
    data = JSON.parse(response.body)

    data["result"].each do |c|
      existing_city = City.find_by_juhe_id( c["id"] )
      if existing_city.nil?
        City.create!( :juhe_id => c["id"], :province => c["province"],
                      :city => c["city"], :district => c["district"] )
      end
    end

    puts "Total: #{City.count} cities"
  end
end

namespace :dev do
  task :fetch_region => :environment do
    puts "Fetch region data..."
    response = RestClient.get "http://pollution.api.juhe.cn/jhapi/pollution/cityList", :params => { :key => "b3a750bbb88a13d46769a18d019ea40a" }
    data = JSON.parse(response.body)

    data["result"].each do |c|
      existing_region = Region.find_by_juhe_code( c["code"] )
      if existing_region.nil?
        Region.create!( :juhe_code => c["code"], :freq => c["freq"], :region => c["region"] )
      end
    end

    puts "Total: #{Region.count} regions"
  end
end
