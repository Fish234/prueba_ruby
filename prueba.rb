require 'uri'
require 'net/http'
require 'json'

def request(url, api_key = "k47dVdRMmA8KoAdnRcznktcGf95YrHTnL4kZyKUr")
    
    url = URI("#{url}&api_key=#{api_key}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request["cache-control"] = 'no-cache'
    request["Postman-Token"] = 'k47dVdRMmA8KoAdnRcznktcGf95YrHTnL4kZyKUr'
    response = http.request(request)
    JSON.parse(response.read_body)
end


def build_web_page(data)
    photos = data["photos"].map {|photo| photo["img_src"]}
    top = "<html>\n<head>\n</head>\n<body>\n<ul>\n"
    html = ""

    photos.each do |photo|
        html += "\t<li><img src=\"#{photo}\"></li>\n"
    end
    closure = "</ul>\n</body></html>\n"
    html = "#{top}"+"#{html}"+"#{closure}"
    File.write('index.html', html)
end



data = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10")
nasa = build_web_page(data)