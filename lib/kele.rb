require 'httparty'
require 'json'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'
  def initialize(email, password)
    options = {

        email: email,
        password: password

    }
    response = self.class.post('/sessions', body: options)

    if response['auth_token']
      @auth_token = response['auth_token']
    else
      puts 'Please enter valid credentials.'
    end
  end

  def get_me
    headers = {
      headers: {
        'authorization' => @auth_token,
        'content_type' => 'application/json'
      }
    }
    response = self.class.get('/users/me', headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end
end
