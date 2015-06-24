module Submail
  class AddressBookMessage
    include Helper

    def initialize(config)
      @address = ""
      @target = ""
      @config = config
    end

    def set_address(address,name)
      @address = "%s<%s>" %[name,address]
    end
    
    def set_addressbook(addressbook)
      @target = addressbook
    end

    def build_request()
      request = {}
      if @address != ""
        request["address"] = @address
      end
      if @target != ""
        request["target"] = @target
      end
      request
    end

    def message_subscribe()
      url = "https://api.submail.cn/addressbook/message/subscribe.json"
      request = self.build_request()
      request["appid"] = @config["appid"]
      request["timestamp"] = get_timestamp()
      request["signature"] = create_signatrue(request, @config)
      JSON.parse http_post(url, request)
    end

    def message_unsubscribe()
      url = "https://api.submail.cn/addressbook/message/unsubscribe.json"
      request = self.build_request()
      request["appid"] = @config["appid"]
      request["timestamp"] = get_timestamp()
      request["signature"] = create_signatrue(request, @config)
      JSON.parse http_post(url, request)
    end
  end
end
