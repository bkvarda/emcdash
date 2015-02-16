require_relative 'arrays'
require_relative 'sr'
require_relative 'gdun'

puts 'job started'
gdun_data = Gdun.static_gdun

puts 'static job gdun is '+gdun_data[0]
puts 'static job gdun name '+gdun_data[1]
SCHEDULER.every '1m' do
  puts 'The Scheduler just ran'
  gdun = gdun_data[0]
  cust_name = gdun_data[1]
  cust_logo = gdun_data[2]
  installs_url = 'http://10.4.44.218:1337/csv/installreport/'+gdun.to_s
  sev1_url ='http://10.4.44.218:1337/csv/sev1report/'+gdun.to_s
  sr_url ='http://10.4.44.218:1337/csv/srreport/'+gdun.to_s 
  array_data = Arrays.getArrayData(gdun)
  expiring_data = Arrays.get_expiring_data(array_data)
  num_expiring = expiring_data.length
  expiring_counts = Arrays.trimArrayCounts(Arrays.get_expired_counts(expiring_data))
  sr_data = Sr.getSRData(gdun)
  array_counts = Arrays.trimArrayCounts(Arrays.getArrayCounts(array_data))
  sev1_hash = Sr.sev1_data(sr_data)
  array_hash = Hash.new({ value: 0 })
  array_counts.each do |array|
   array_hash[array[0]] = { label: array[0], value: array[1].to_s, link: installs_url }
  end
  expiring_hash = Hash.new({ value: 0 })
  expiring_counts.each do |array|
   expiring_hash[array[0]] = { label: array[0], value: array[1].to_s }
  end
  test_hash = Hash.new()
  sr_counts = Sr.countSRBySev(sr_data)
  sr_array = []
  sr_array.push ['SR Severity', 'Quantity']
  sr_counts.each do |array|
   sr_array.push [array[0],array[1]]
  end
 
  send_event('static_mychart', slices: sr_array)
  send_event('static_total_srs', { value: sr_data["rows"].length(), link: sr_url })
  send_event('static_array_counts',   { items: array_hash.values })
  send_event('static_sev_1s', { value: sr_counts['S1'] || 0, link: sev1_url })
  send_event('static_picture', image: cust_logo)
  send_event('static_sev1_data', { items: sev1_hash.values, link: sev1_url })
  send_event('static_num_expiring', value: num_expiring)
  send_event('static_expiring_counts', { items: expiring_hash.values })
 end
