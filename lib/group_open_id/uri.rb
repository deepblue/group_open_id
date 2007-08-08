module GroupOpenID
  class URI
    def initialize(uri, client)
      @uri, @client = uri, client
    end
    
    def membership_location
      @client.membership_location(@uri)
    end
    
    def members
      @client.members(@uri)
    end
    
    def member?(openid)
      @client.member?(@uri, openid)
    end
  end
end