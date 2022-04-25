require 'rack'

class TimeFormatter

  TIME_FORMATS = {'year'=> '%Y', 'month'=> '%m', 'day'=> '%d', 'hour'=> '%H', 'minute'=> '%m', 'second'=> '%S'}.freeze
  
  attr_reader :params

  def initialize(params)
    @params = params.split(',')
  end

  def time
    body = self.params.reduce('') { |body, param| body << TIME_FORMATS[param] }
    body = body.split('').join('-')
    Time.now.strftime(body)
  end

  def invalid_params
    self.params - TIME_FORMATS.keys
  end

  def valid?
    invalid_params.empty?
  end
end
