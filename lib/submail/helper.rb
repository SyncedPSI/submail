module Submail
  module Helper
    def http_get(url)
      uri = URI.parse(url)
      request = Net::HTTP::Get.new(uri.to_s)
      http_request(uri, request)
    end

    def http_post(url, postdata)
      uri = URI.parse(url)
      request = Net::HTTP::Post.new(uri.to_s)
      request.set_form_data postdata
      http_request(uri, request)
    end

    def http_request(uri, request)
      response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request request
      end
      response.body
    end

    def get_timestamp
      json = JSON.parse http_get("https://api.submail.cn/service/timestamp.json")
      json["timestamp"]
    end

    def create_signatrue(request, config)
      appkey = config["appkey"]
      appid = config["appid"]
      signtype = config["signtype"]
      request["sign_type"] = signtype
      keys = request.keys.sort
      values = []
      keys.each do |k|
        values << "%s=%s"%[k,request[k]]
      end
      signstr = "%s%s%s%s%s"%[appid,appkey, values.join('&'),appid, appkey]
      if signtype == "normal"
        appkey
      elsif signtype == "md5"
        Digest::MD5.hexdigest(signstr)
      else
        Digest::SHA1.hexdigest(signstr)
      end
    end
  end
end
