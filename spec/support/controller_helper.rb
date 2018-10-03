# frozen_string_literal: true

def json_response
  @json_response ||= JSON.parse(response.body).with_indifferent_access
end

def authenticated_header(user:)
  return {} if user.blank?

  user.create_new_auth_token
end
