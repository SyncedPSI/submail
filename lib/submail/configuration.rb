module Submail
  class Configuration
    attr_accessor :message_app_id, :message_app_key, :signtype

    def initialize(options = {})
      options.each { |key, value| 
        instance_variable_set("@#{key}", value)
      }
    end

    def message_json
      { "appid" => message_app_id, "appkey" => message_app_key, "signtype" => signtype }
    end
  end
end
