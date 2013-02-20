require 'base64'
require 'json'
require 'net/http'
require 'openssl'


class Civshare
  def initialize merchant_id, secret_key
    @merchant = merchant_id
    @secret = secret_key
    @url = default_url
  end

  def set_url url
    @url = url
  end

  def transact values
    values.merge!(merchant_id: @merchant)
    require_keys values, :merchant_id, :customer_email, :quantity
    limit_keys values, :merchant_id, :customer_email, :quantity,
                       :customer_name, :default_recipient_id, :is_test
    signature = sign(values[:quantity], values[:customer_email])
    request(@url, values.merge(signature: signature))
  end

  private

  def default_url
    'https://civchoice.com/civ_gifts/ecommerce_create'
  end

  def require_keys hash, *key_list
    missing_keys = key_list.select{|k| !hash.has_key?(k) }
    if missing_keys.any?
      raise "Missing required keys: #{missing_keys.inspect}"
    end
  end

  def limit_keys hash, *key_list
    extra_keys = hash.keys.select{|k| !key_list.include?(k) }
    if extra_keys.any?
      raise "Unknown keys: #{extra_keys}"
    end
  end

  def sign quantity, email
    data = "#{quantity}|#{email}"
    sha256 = OpenSSL::Digest::SHA256.new
    hmac = OpenSSL::HMAC.digest(sha256, @secret, data)
    Base64.urlsafe_encode64(hmac)
  end

  def request url, values
    params = {transaction: values.to_json}
    uri = URI.parse(@url)
    connection = Net::HTTP.new(uri.host, uri.port)
    if uri.scheme == 'https'
      connection.use_ssl = true
      connection.verify_mode = OpenSSL::SSL::VERIFY_PEER
    end
    request = Net::HTTP::Post.new(uri.request_uri)
    request['Accept'] = 'application/json'
    request.set_form_data params
    response = connection.request(request)
    WrappedResponse.new(response)
  end

  class WrappedResponse
    attr_reader :response

    def initialize net_http_response
      @response = net_http_response
    end

    def success?
      @response.code == '200'
    end

    def message
      "The server responded with #{@response.code}, saying: #{@response.body}"
    end
  end
end
