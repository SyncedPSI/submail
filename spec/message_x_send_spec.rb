RSpec.describe Submail::MessageXSend do
  describe "#message_xsend" do
    subject { instance }

    context "when request" do
      let(:config) {
        config = {}
        config["appid"] = "your_message_app_id"
        config["appkey"] = "your_message_app_key"
        config["signtype"] = "md5"
      }
      let(:instance) { Submail::MessageXSend.new(config) }
      before {
        allow(instance).to receive(:get_timestamp).and_return(0)
        allow(instance).to receive(:http_post).and_return('{"status":"error","code":"101","msg":"Incorrect APP ID"}')
        @result = instance.message_xsend
      }
      it { expect(subject).to have_received(:get_timestamp).once }
      it { 
        expect(subject).to have_received(:http_post).with(kind_of(String), {
          "appid" => nil, "timestamp" => 0, "sign_type" => nil, 
          "signature" => "110fa0af8f323f1819ecf1086f9c608cf8806520"
          }).once 
      }
      it { expect(@result["code"]).to eq "101" }
    end
  end
end
