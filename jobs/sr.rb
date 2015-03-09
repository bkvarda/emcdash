module Sr

require 'httpi'
require 'json'
require 'date'

@json = JSON.parse(File.read('config/config.json'))
@config = @json['config']
@username = @config['username'] 
@pass = @config['password']
@domain = @config['domain']
@url1 = @config['srurl']
@url2 = @config['srurl2']

def Sr. getSRData(gdun)
 url = @url1+gdun+@url2
 request = HTTPI::Request.new
 request.url = url
 request.auth.ntlm(@username, @pass, @domain)
 response = HTTPI.get(request)
 sr_data = JSON.parse(response.body)
 return sr_data
end

def Sr.countSRBySev(sr_data)
 data = sr_data
 data = data["rows"]
 counts = {}
  data.each do |sr|
  if counts[sr['Sev']]
  counts[sr['Sev']] +=1
  else
  counts[sr['Sev']] = 1
  end
 end
 return counts
end

def Sr.sev1_data(sr_data)
 data = sr_data
 data = data["rows"]
 sev1_data = Hash.new()
 sev1_data['Headers'] = { col1: 'SR Num. ', col2: 'Age', col3: 'Family   ', col4: 'Site Name' }
 data.each do |sr|
  if sr['Sev'] == 'S1'
   sev1_data[sr['SR_NUMBER']] = { col1: sr['SR_NUMBER'] , col2: sr['Age'].to_i , col3: sr['Family'] , col4: sr['CS Customer Name'] }
  end
 end
 return sev1_data
end

end
