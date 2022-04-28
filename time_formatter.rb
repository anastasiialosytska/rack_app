require 'rack'

class TimeFormatter

  TIME_FORMATS = {'year'=> '%Y', 'month'=> '%m', 'day'=> '%d', 'hour'=> '%H', 'minute'=> '%m', 'second'=> '%S'}.freeze
  
  attr_reader :params

  def initialize(params)
    @params = params.split(',')
  end

  def call
    if self.success?
      time
    else
      invalid_string
    end
  end

  def time
    Time.now.strftime(time_string)
  end

  def time_string
    body = self.params.reduce('') { |body, param| body << TIME_FORMATS[param] }
    body = body.split('').join('-')
  end

  def invalid_string
    self.params - TIME_FORMATS.keys
  end

  def success?
    invalid_string.empty?
  end
end
