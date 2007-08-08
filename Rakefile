require 'rubygems'
require 'hoe'
require './lib/group_open_id/version'

Hoe.new('group_open_id', GroupOpenID::VERSION) do |p|
  p.rubyforge_name = 'springnote'
  p.summary = "Wrapper library for myID.net's Group ID API"
  p.author = 'Bryan Kang'
  p.email = 'byblue@gmail.com'
  p.description = p.paragraphs_of('README.txt', 2..5).join("\n\n")
  p.url = p.paragraphs_of('README.txt', 0).first.split(/\n/)[1..-1]
  p.changes = p.paragraphs_of('History.txt', 0..1).join("\n\n")
  p.need_zip = true
  p.extra_deps << ['hpricot', [">= 0.6"]]
end
