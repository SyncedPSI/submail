module Submail
  class MessageXSend
    include Helper

    def initialize(config = Submail::configuration.message_json)
      @to = []
      @addressbook = []
      @project = ""
      @vars ={}
      @config = config
    end

    def add_to(address)
      @to << address
    end

    def add_addressbook(addressbook)
      @addressbook << addressbook
    end

    def set_project(project)
      @project = project
    end

    def add_var(key, value)
      @vars[key] = value
    end
    
    def build_request
      request = {}
      if @to.length != 0
        request["to"] = @to.join(",")
      end
      if @addressbook.length != 0
        request["addressbook"] = @addressbook.join(",")
      end
      if @project != ""
        request["project"] = @project
      end
      if @vars.length != 0
        request["vars"] = JSON.generate @vars
      end
      request
    end

    def message_xsend
      request = self.build_request
      url = "https://api.submail.cn/message/xsend.json"
      request["appid"] = @config["appid"]
      request["timestamp"] = get_timestamp
      request["signature"] = create_signatrue(request, @config)
      JSON.parse http_post(url, request)
    end
  end
end
