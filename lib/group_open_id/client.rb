require File.dirname(__FILE__) + '/fetcher'
require 'hpricot'

module GroupOpenID
  class Client
    attr_accessor :user_key, :user_openid, :logger
    
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
      parse_members(fetcher.get(url))
    end
    
    def owner(group)
      url = "#{ensure_https(group)}owner?format=xml"
      parse_members(fetcher.get(url))[0]
    end
        
    def group_list(owned = false)
      url = "https://www.#{openid_host}/user/#{encode_url(@user_openid)}/group?format=xml"
      url += "&reverse=owner" if owned
      parse_members(fetcher.get(url))
    end
        
    def member?(group, member)
      (url = membership_location(group)) or raise InvalidGroupID
      url += '?openid=' + CGI.escape(::URI.parse(member).normalize.to_s)
      fetcher.head(url)['x-myid-membership'].to_s == 'true'
    end

    def owner?(group, member)
      owner(group).openid == member
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
    
    attr_writer :openid_host
    def openid_host
      @openid_host || 'myid.net'
    end
    
    def encode_url(url)
      url.gsub('-', '-_').gsub('/', '--')
    end
    
    def ensure_https(url)
      uri = ::URI.parse(group)
      uri.scheme = 'https'
      uri.to_s
    end
  end
end