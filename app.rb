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

    return [404, headers, ["Unknown request\n"]] if path != '/time' || request_params.nil?

    formatter = TimeFormatter.new(request_params)
    if formatter.valid?
      body = formatter.time
      status = 200
    else
      invalid_params = formatter.invalid_params
      body = "Unknown time format #{invalid_params}"
      status = 400
    end
    [status, headers, ["#{body}\n"]]
  end

  def headers
    { 'Content-Type' => 'text/plain'}
  end
end
