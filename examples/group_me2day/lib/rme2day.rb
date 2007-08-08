require 'cgi'
$LOAD_PATH << SETTING['me2day']['rme2day_path']
require 'rme2day'
Rme2day::API.setup SETTING['me2day']['user_id'], SETTING['me2day']['user_key'], SETTING['me2day']['app_key']

class Rme2day::API
  def self.get_person_by_openid(person_openid)
    do_open get_person_by_openid_url(person_openid) 
  end

  def self.get_person_by_openid_url(person_openid)
    "http://#{DOMAIN}/api/get_person.xml?openid=#{CGI.escape(person_openid)}"
  end
end