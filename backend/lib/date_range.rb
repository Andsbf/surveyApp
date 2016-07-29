class DateRange < Range
  def initialize(start, finish)
    @start = start.to_datetime.beginning_of_day
    @finish = finish.to_datetime.beginning_of_day
  end

  # step is similar to DateTime#advance argument
  def every(step)
    return [@start] unless @finish > @start

    [].tap do |range|
      while @start <= @finish do
        range << @start.to_date.to_s
        @start = @start.advance(step)
      end
    end
  end
end
