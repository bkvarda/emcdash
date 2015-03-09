module Gdun

require 'json'

 def Gdun.random_gdun
  json = File.read('config/config.json')
  data = JSON.parse(json)
  gduns = data['accounts']
  return gduns.sample
 end

 def Gdun.static_gdun
  json = File.read('config/config.json')
  data = JSON.parse(json)
  config = data['config']
  gdun = [config['gdun'],config['gdun_name'],config['gdun_image']]

  return gdun
 end



end
