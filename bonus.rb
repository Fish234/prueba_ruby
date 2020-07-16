require 'uri'
require 'net/http'
require 'json'

def request(url, api_key = "caJyYW2hcGTpc0V1IwO6oNqEgrFs9jPjEsyx4xb3")
    url = URI("#{url}&api_key=#{api_key}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request["cache-control"] = 'no-cache'
    request["Postman-Token"] = 'caJyYW2hcGTpc0V1IwO6oNqEgrFs9jPjEsyx4xb3'
    response = http.request(request)
    JSON.parse(response.read_body)
end

def photos_count(hash)
    cams = []
    cams = hash["photos"].map {|x|x["camera"]["name"]}
    counter = cams.group_by{|x| x}
    counter.each do |k,v|
        counter[k] = v.count
    end
    return (counter)
end
data = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10")
print(photos_count(data))