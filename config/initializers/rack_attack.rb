if Rails.env.production?
  # Rack::Attack.throttle("req/ip", :limit => 30, :period => 1) { |req| req.ip }
end
