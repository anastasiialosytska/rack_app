require_relative 'time_formatter'

class App
  def call(env)
    perform_response(env)
  end

  private

  def perform_response(env)
    request = Rack::Request.new(env)

    path = request.path
    request_params = request.params['format']

    return response(404, "Unknown request") if path != '/time' || request_params.nil?

    formatter = TimeFormatter.new(request_params)
    formatter.call
    if formatter.success?
      response(200, "#{formatter.time}")
    else
      response(400, "#{formatter.invalid_string}")
    end
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def response(status, body)
    Rack::Response.new(body, status, headers).finish
  end
end
