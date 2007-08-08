require 'yaml'
SETTING = YAML.load(File.read('setting.yml'))

require 'lib/rme2day'
require File.dirname(__FILE__) + '/../../lib/group_open_id'
GroupOpenID::Client.app_key = SETTING['myid']['app_key']

client = GroupOpenID::Client.new(SETTING['myid']['user_id'], SETTING['myid']['user_key'])
group_id = GroupOpenID::URI.new(SETTING['target'], client)

group_id.members[0..10].map do |member|
  Rme2day::Person.parse(Rme2day::API.get_person_by_openid(member.openid))[0] rescue nil
end.compact.each do |profile|
  puts "#{profile.nickname} (#{profile.openid})"
  post = profile.newest_post
  puts " - #{post.body} at #{post.pubdate}"
end
