require 'httparty'
require 'pry'
class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'



  def initialize(u, pass)
    @auth = { email: u, password: pass }

    response = self.class.post('https://www.bloc.io/api/v1/sessions',{body: @auth})


    if response["message"] == "Email or password was incorrect"
      raise "FUCK THIS"
    else
      @token = response["auth_token"]
    end
  end

  def self.hi
    puts "Hello World"
  end


end
