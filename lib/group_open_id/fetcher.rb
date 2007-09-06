module GroupOpenID
  class Fetcher
    def initialize(config = {})
      @config = config
    end
    
    def username
      CGI.escape(@config.user_openid)
    end
    
    def password
      [@config.user_key, GroupOpenID::Client.app_key].join('.')
    end
    
    def default_params
      { :http_basic_authentication => [username, password] }
    end
    
    def head(url)
      log "HEAD #{url}"
      open(url, default_params.merge(:method => :head)).meta
    end
    
    def get(url)
      log "GET #{url}"
      open(url, default_params).read
    end    
    
    def log(msg)
      @config.logger.info(msg) if @config.logger
    end
  end
end