require 'httparty'
require 'json'
require_relative 'roadmap'


class Kele
  include HTTParty
  include Roadmap
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

    response = self.class.get('/users/me', headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)

    response = self.class.get("/mentors/#{mentor_id}/student_availability", headers)
    JSON.parse(response.body)
  end

  def get_messages(page = nil)
    if page == nil
      response = self.class.get("/message_threads", headers: { "authorization" => @auth_token })
    else
      response = self.class.get("/message_threads?page=#{page}", headers: { "authorization" => @auth_token })
    end
    JSON.parse(response.body)
  end

  def create_message(sender, recipient_id, subject, text, token=nil)
    body = {
      sender: sender,
      recipient_id: recipient_id,
      subject: subject,
      "stripped-text" => text
    }
    body[:token] = token if token
    new_message = self.class.post("/messages", body: body, headers: { "authorization" => @auth_token })
  end

  def update_submission(checkpoint_submission_id, checkpoint_id, assignment_branch, assignment_commit_link, comment, enrollment_id)
    body = {
      "assignment_branch": assignment_branch,
      "assignment_commit_link": assignment_commit_link,
      "checkpoint_id": checkpoint_id,
      "comment": comment,
      "enrollment_id": enrollment_id
    }
    response = self.class.post("/checkpoint_submissions", body: body, headers: { "authorization" => @auth_token})
    puts response
  end

  private

  def headers
    {
      headers: {
        'authorization' => @auth_token,
        'content_type' => 'application/json'
      }
    }
  end
end
