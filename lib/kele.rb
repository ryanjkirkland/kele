require 'httparty'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(u, pass)
    @auth = { username: u, password: pass }
    self.class.post('https://www.bloc.io/api/v1/sessions' ,@auth)
  end

  def self.hi
    puts "Hello World"
  end
end
