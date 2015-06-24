module Submail
  class MailXSend
    include Helper

    def initialize(config)
      @to = []
      @addressbook = []
      @from = ""
      @fromname = ""
      @reply = ""
      @cc = []
      @bcc = []
      @subject = ""
      @project = ""
      @vars ={}
      @links = {}
      @headers = {}
      @config = config
    end

    def add_to(address, name)
      to = {}
      to["address"] = address
      to["name"] = name
      @to << to
    end

    def add_addressbook(addressbook)
      @addressbook = []
      @addressbook << addressbook
    end

    def set_sender(from, fromname)
      @from = from
      @fromname = fromname
    end

    def set_reply(reply)
      @reply = reply
    end

    def add_cc(address, name)
      cc = {}
      cc["address"] = address
      cc["name"] = name
      @cc << cc
    end

    def add_bcc(address, name)
      bcc = {}
      bcc["address"] = address
      bcc["name"] = name
      @bcc << bcc
    end

    def set_subject(subject)
      @subject = subject
    end

    def set_project(project)
      @project = project
    end

    def add_var(key, value)
      @vars[key] = value
    end

    def add_link(key, value)
      @links[key] = value
    end

    def add_header(key, value)
      @headers[key] = value
    end
    
    def build_request
      request = {}
      if @to.length != 0
        to = []
        @to.each do |k| 
          to << "%s<%s>" %[k["name"], k["address"]]
        end
        request["to"] = to.join(",")
      end
      if @addressbook.length != 0
        request["addressbook"] = @addressbook.join(",")
      end
      if @from != ""
        request["from"] = @from
      end
      if @fromname != ""
        request["from_name"] = @fromname
      end
      if @reply != ""
        request["reply"] = @reply
      end
      if @cc.length != 0
        cc = []
        @cc.each do |k| 
          cc << "%s<%s>" %[k["name"], k["address"]]
        end
        request["cc"] = cc.join(",")
      end
      if @bcc.length != 0
        bcc = []
        @bcc.each do |k| 
          bcc << "%s<%s>" %[k["name"], k["address"]]
        end
        request["bcc"] = bcc.join(",")
      end
      if @subject != ""
        request["subject"] = @subject
      end
      if @project != ""
        request["project"] = @project
      end
      if @vars.length != 0
        request["vars"] = JSON.generate @vars
      end
      if @links.length != 0
        request["links"] = JSON.generate @links
      end
      
      if @headers.length != 0
        request["headers"] = JSON.generate @headers
      end
      request
    end

    def mail_xsend
      request = self.build_request()
      url = "https://api.submail.cn/mail/xsend.json"
      request["appid"] = @config["appid"]
      request["timestamp"] = get_timestamp()
      request["signature"] = create_signatrue(request, @config)
      JSON.parse http_post(url, request)
    end
  end
end
