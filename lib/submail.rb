# require "net/http"
require "net/https"
require "json"
require "digest/md5"
require "digest/sha1"

require "submail/version"
require "submail/configuration"
require "submail/helper"
require "submail/address_book_mail"
require "submail/address_book_message"
require "submail/mail_send"
require "submail/mail_x_send"
require "submail/message_x_send"

module Submail
  def self.configure(&block)
    yield configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
end
