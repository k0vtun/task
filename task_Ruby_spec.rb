require 'rspec/autorun'
require 'net/http'
require 'json'

RSpec.describe do
	
	it 'Returns GET data' do
		uri = URI('http://httpbin.org/get')
		response = Net::HTTP.get(uri)
		tmp = JSON.parse(response)
		expect(tmp['url']).to eq 'http://httpbin.org/get'
	end
	
end

RSpec.describe do
	it 'Renders an HTML Page' do
		uri = URI('http://httpbin.org/html')
		response = Net::HTTP.get(uri)
		if      response.include? '<body>'  and
				response.include? '<html>'  and
				response.include? '</body>' and
				response.include? '</html>'
		a = 1
    		else
		a = 0
		end
		expect(a).to eq 1
	end
end

RSpec.describe do
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

RSpec.describe do

    form_data = { 'custname' => 'john',
                  'custtel' => '12345678',
                  'custemail' => 'aa@vv.cc',
                  'size' => 'large',
                  'topping' => 'bacon',
                  'delivery' => '15:00',
                  'comments' => 'Wanna pizza' }

    it 'Verify POST data' do
            uri = URI.parse("http://httpbin.org/post")
            response = Net::HTTP.post_form(uri, form_data)
            ret = JSON.parse(response.body)['form']
                   
		expect(ret == form_data).to eq true
        expect(ret).to eq form_data
		
    end
end

RSpec.describe do
	
	it 'Returns not allowed method for form' do # Negative test case for httpbin.org/forms/post.
		uri = URI('http://httpbin.org/post')
		req = Net::HTTP::Get.new(uri)
		response = Net::HTTP.start(uri.hostname, uri.port){|http|
		http.request(req)
		}
		expect(response.code).to eq "405" #HTTP 405 Method Not Allowed
		#User can not get permission to http://httpbin.org/post
		#without submitting form at httpbin.org/forms/post
	end
	
end