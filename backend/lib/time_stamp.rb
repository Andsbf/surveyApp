class TimeStamp
  attr_reader :precision, :datetime

  def initialize(precision, datetime)
    @precision = precision
    @datetime  = datetime
  end

  def generate
    case precision
    when 'hour'.freeze
      current_hour
    when 'day'.freeze
      current_day
    when 'month'.freeze
      current_month
    end
  end

  def current_hour
    datetime.strftime("%Y-%m-%d %H:00")
  end

  def current_day
    datetime.strftime("%Y-%m-%d")
  end

  def current_month
    datetime.strftime("%Y-%m")
  end

end
