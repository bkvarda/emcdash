module Arrays

require 'httpi'
require 'json'
require 'date'

@config = JSON.parse(File.read('config/config.json'))
puts @config
@username = @config['username']
@pass = @config['password']
@domain = @config['domain']
@url1 = @config['iburl']
@url2 = @config['iburl2']


def Arrays.getArrayData (gdun)
 url = @url1+gdun+@url2
 request = HTTPI::Request.new
 request.url = url
 request.auth.ntlm(@username,@pass,@domain)
response = HTTPI.get(request)
array_data = JSON.parse(response.body)
return array_data
end


def Arrays.getArrayCounts (array_data)
 data = array_data
 data = data["rows"]
 counts= {}
  data.each do |array|
  if array['INSTALL_BASE_STATUS'] == 'Install'
   if counts[array['PRODUCT_FAMILY']]
     counts[array['PRODUCT_FAMILY']] +=1
   else
    counts[array['PRODUCT_FAMILY']] = 1
   end
  end
 end
 return counts
end

def Arrays.get_expired_counts (expired_data)
  data = expired_data
  counts= {}
   data.each do |array|
   if array['INSTALL_BASE_STATUS'] == 'Install'
    if counts[array['PRODUCT_FAMILY']]
      counts[array['PRODUCT_FAMILY']] +=1
    else
     counts[array['PRODUCT_FAMILY']] = 1
    end
   end
  end
  return counts
end

def Arrays.get_expiring_data(array_data)
 data = array_data
 data = data["rows"]
 expiring = []
 today = Time.now
 data.each do |array|
  if array['CONTRACT_SUBLINE_END_DATE']
   expiration_date = Time.parse(array['CONTRACT_SUBLINE_END_DATE'])
   days_til_expire = (expiration_date - today)/(60*60*24)
   puts days_til_expire
   if array['INSTALL_BASE_STATUS'] == 'Install' && days_til_expire > 0 && days_til_expire < 120
    expiring.push(array)
   end
  end
 end
 return expiring
end

def Arrays.trimArrayCounts(counts)
 array_counts = counts
 counts = {
 'VNX' => 0,
 'Symmetrix' => 0,
 'XtremIO' => 0,
 'Clariion' => 0,
 'Isilon' => 0,
 'Connectrix' => 0,
 'Recoverpoint' => 0,
 'Data Domain' => 0,
 'Avamar' => 0,
 'VPLEX' => 0,
 'ScaleIO' => 0,
 'ECS/ViPR' => 0,
 'Other' => 0
 }
 array_counts.each do |array|
  if array[0].include? "VNX"
  counts['VNX'] += array[1]
  elsif array[0].include? "SYMMETRIX"
  counts['Symmetrix'] += array[1]
  elsif array[0].include? "DATADOMAIN"
  counts['Data Domain'] += array[1]
  elsif array[0].include? "ISILON"
  counts['Isilon'] += array[1]
  elsif array[0].include? "XTREMIO"
  counts['XtremIO'] += array[1]
  elsif array[0].include? "CONNECTRIX"
  counts['Connectrix'] += array[1]
  elsif array[0].include? "RECOVERPOINT"
  counts['Recoverpoint'] += array[1]
  elsif array[0].include? "AVAMAR"
  counts['Avamar'] += array[1]
  elsif array[0].include? "VPLEX"
  counts['VPLEX'] += array[1]
  elsif array[0].include? "CLARIION"
  counts['Clariion'] += array[1]
  elsif array[0].include? "CELERRA"
  counts['Clariion'] += array[1]
  elsif array[0].include? "VIPR"
  counts['ECS/ViPR'] += array[1]
  elsif array[0].include? "SCALEIO"
  counts['ScaleIO'] += array[1]
  elsif array[0].include? "ECS"
  counts['ECS/ViPR'] += array[1]
  else
  counts['Other'] += array[1]
  end
 end
 return counts
end

end
