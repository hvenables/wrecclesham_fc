class Rack::Attack

  throttle('logins/ip', limit: 5, period: 20.seconds) do |req|
    req.ip if req.path == '/users/sign_in' && req.post?
  end

  throttle('logins/email', limit: 5, period: 20.seconds) do |req|
    req.params['email'].presence if req.path == '/users/sign_in' && req.post?
  end

end
