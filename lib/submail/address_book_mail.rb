module Submail
  class AddressBookMail
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

    def build_request
      request = {}
      if @address != ""
        request["address"] = @address
      end
      if @target != ""
        request["target"] = @target
      end
      request
    end

    def mail_subscribe
      url = "https://api.submail.cn/addressbook/mail/subscribe.json"
      request = self.build_request()
      request["appid"] = @config["appid"]
      request["timestamp"] = get_timestamp()
      request["signature"] = create_signatrue(request, @config)
      JSON.parse http_post(url, request)
    end

    def mail_unsubscribe
      url = "https://api.submail.cn/addressbook/mail/unsubscribe.json"
      request = self.build_request()
      request["appid"] = @config["appid"]
      request["timestamp"] = get_timestamp()
      request["signature"] = create_signatrue(request, @config)
      JSON.parse http_post(url, request)
    end
  end
end
