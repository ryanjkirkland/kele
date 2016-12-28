require 'httparty'
require 'pry'
require 'json'
require './lib/road'

class Kele
  include Road
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

  def get_me
    response = self.class.get('https://www.bloc.io/api/v1/users/me', headers: { "authorization" => @token })
    JSON.parse(response.body)
  end

  def get_mentor(mentor_id)
    response = self.class.get("https://www.bloc.io/api/v1/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @token })
    puts response
    JSON.parse(response.body)
  end

  def get_messages(page = nil)
    query = (page ? "?page=#{page}" : "")

    response = self.class.get("https://www.bloc.io/api/v1/message_threads" + query, headers: { "authorization" => @token })

    JSON.parse(response.body)
  end

  def create_message(sender, recipient_id, token, subject, stripped_text)
    values = {
      sender: sender,
      recipient_id: recipient_id,
      # token: token,
      subject: subject,
      "stripped-text": stripped_text
    }

    headers = {
      # "content_type" => 'application/json',
      "authorization" => @token
    }

    response = self.class.post('https://www.bloc.io/api/v1/messages', body: values, headers: headers)
    puts response
  end
end
