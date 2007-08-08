require 'hpricot'
require File.dirname(__FILE__) + '/fetcher'

module GroupOpenID
  class Client
    attr_accessor :user_key, :user_openid
    
    class <<self
      attr_accessor :app_key
    end  
    
    def initialize(user_openid = '', user_key = '')
      @user_key, @user_openid = user_key, user_openid
    end
      
    def membership_location(group)
      fetcher.head(group)['x-myid-membership-location']
    end
    alias_method :group_id?, :membership_location

    def members(group)
      (url = membership_location(group)) or raise InvalidGroupID
      url += '?format=xml'
      p url
      parse_members(fetcher.get(url))
    end
    
    def member?(group, member)
      (url = membership_location(group)) or raise InvalidGroupID
      url += '?openid=' + CGI.escape(::URI.parse(member).normalize.to_s)
      fetcher.head(url)['x-myid-membership'].to_s == 'true'
    end
    
    attr_writer :fetcher
    def fetcher
      @fetcher ||= Fetcher.new(self)
    end
    
    def parse_members(doc)
      Hpricot(doc).search('//relation').map do |rel|
        member = Member.new
        member.members.each{|sym| member.send("#{sym}=", rel.at(sym).inner_html)}
        member
      end 
    end
  end
end