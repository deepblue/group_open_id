require 'rubygems'
require 'cgi'
require File.dirname(__FILE__) + '/../vendor/rest-open-uri'
require File.dirname(__FILE__) + '/group_open_id/client'
require File.dirname(__FILE__) + '/group_open_id/uri'

module GroupOpenID
  VERSION = '0.1'
  Member = Struct.new(:openid, :name, :email)
       
  class InvalidGroupID < Exception; end
end