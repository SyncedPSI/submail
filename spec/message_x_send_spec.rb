RSpec.describe Submail::MessageXSend do
  describe "#message_xsend" do
    subject { instance }

    context "with config" do
      let(:instance) { 
        Submail::MessageXSend.new({ 
          "appid" => "your_message_app_id",
          "appkey" => "your_message_app_key",
          "signtype" => "md5" }) 
      }
      before {
        allow(instance).to receive(:get_timestamp).and_return(0)
        allow(instance).to receive(:http_post).and_return('{"status":"error","code":"101","msg":"Incorrect APP ID"}')
        @result = instance.message_xsend
      }
      it { expect(subject).to have_received(:get_timestamp).once }
      it { 
        expect(subject).to have_received(:http_post).with(kind_of(String), {
          "appid" => "your_message_app_id", "timestamp" => 0, "sign_type" => "md5", 
          "signature" => "780aa10fa9e95f3bf91c90bf5d3e78c8"
          }).once 
      }
      it { expect(@result["code"]).to eq "101" }
    end

    context "without config" do
      let(:instance) { Submail::MessageXSend.new }
      before {
        Submail.configure do |config|
          config.message_app_id = "your_message_app_id"
          config.message_app_key = "your_message_app_key"
          config.signtype = "md5"
        end

        allow(instance).to receive(:get_timestamp).and_return(0)
        allow(instance).to receive(:http_post).and_return('{"status":"error","code":"101","msg":"Incorrect APP ID"}')
        @result = instance.message_xsend
      }
      it { expect(subject).to have_received(:get_timestamp).once }
      it { 
        expect(subject).to have_received(:http_post).with(kind_of(String), {
          "appid" => "your_message_app_id", "timestamp" => 0, "sign_type" => "md5", 
          "signature" => "780aa10fa9e95f3bf91c90bf5d3e78c8"
          }).once 
      }
      it { expect(@result["code"]).to eq "101" }
    end
  end
end
