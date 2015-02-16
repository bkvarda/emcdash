module Gdun

require 'json'

 def Gdun.random_gdun
  gduns =[
  ['081466849','Microsoft','http://i.imgur.com/8MuBOXp.jpg'],
  ['155366107','Starbucks','http://i.imgur.com/RO5vgMj.png'],
  ['009256819','Boeing','http://i.imgur.com/m1FPr1h.jpg'],
  ['092180517','Expedia','http://i.imgur.com/HRLzfZZ.jpg'],
  ['103391843','Costco','http://i.imgur.com/QM9VL8V.jpg'],
  ['048341267','Paccar','http://i.imgur.com/Z5OVd5c.jpg'],
  ['831703157','PSE','http://i.imgur.com/Ij2jv7O.jpg'],
  ['884727413','Providence Health','http://i.imgur.com/BMpRvNJ.jpg'],
  ['327376653','T-Mobile','http://i.imgur.com/hZKFuvp.png'],
  ['047897855','Intel','http://i.imgur.com/uxixdRc.png'],
  ['007947146','Russell Investments','http://i.imgur.com/Sh5e38o.jpg']
  ]
  return gduns.sample
 end

 def Gdun.static_gdun
  config = JSON.parse(File.read('config/config.json'))
  gdun = [config['gdun'],config['gdun_name'],config['gdun_image']]

  return gdun
 end



end
