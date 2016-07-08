require 'net/http'
require 'json'

describe do
	
	it 'Returns GET data' do
		uri = URI('http://httpbin.org/get')
		response = Net::HTTP.get(uri)
		tmp = JSON.parse(response)
		expect(tmp['url']).to eq 'http://httpbin.org/get'
	end
	
end

describe do
	it 'Renders an HTML Page' do
		uri = URI('http://httpbin.org/html')
		response = Net::HTTP.get(uri)
		if      response.include? '<body>'  and
				response.include? '<html>' and
				response.include? '</body>' and
				response.include? '</html>'
		a = 1
    		else
		a = 0
		end
expect(a).to eq 1
	end
end

describe do
	it 'Challenges HTTPBasic Auth' do
		uri = URI('http://httpbin.org/basic-auth/user/passwd')
		req = Net::HTTP::Get.new(uri)
		req.basic_auth 'user', 'passwd'
		response = Net::HTTP.start(uri.hostname, uri.port){|http|
		http.request(req)
		}
		expect(response.code).to eq "200" #HTTP 200 OK
	end
end