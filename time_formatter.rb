require 'rack'

class TimeFormatter

  TIME_FORMATS = {'year'=> '%Y', 'month'=> '%m', 'day'=> '%d', 'hour'=> '%H', 'minute'=> '%m', 'second'=> '%S'}.freeze
  
  attr_reader :params

  def initialize(params)
      @params = params.split(',')
      @available_formats = []
      @unknown_formats = []
  end

  def call
    @params.each do |format|
      if TIME_FORMATS[format]
        @available_formats << TIME_FORMATS[format]
      else
        @unknown_formats << format
      end
    end
  end

  def success?
    @unknown_formats.empty?
  end

  def invalid_string
    "Unknown time format #{@unknown_formats}"
  end

  def time
    Time.now.strftime(@available_formats.join('-'))
  end
end
