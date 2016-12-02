class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'
  def self.new(email, password)
    options = {
        body: {
            email: email,
            password: password
        }
    }
    response = self.post('/sessions', options)

    if response['auth_token']
      response['auth_token']
    else
      'Please enter valid credentials.'
    end
  end
end
