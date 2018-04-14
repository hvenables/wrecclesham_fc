# frozen_string_literal: true

class Rack::Attack
  safelist('allow from localhost') do |req|
    # Requests are allowed if the return value is truthy
    req.ip == '127.0.0.1' || req.ip == '::1'
  end

  throttle('logins/ip', limit: 5, period: 20.seconds) do |req|
    req.ip if req.path == '/users/sign_in' && req.post?
  end

  throttle('logins/email', limit: 5, period: 20.seconds) do |req|
    req.params['email'].presence if req.path == '/users/sign_in' && req.post?
  end
end
