module HealthService
  module_function

  def system_health
    {
      web: web_health,
      workers: workers_health,
    }
  end

  def web_health
    { status: :ok }
  end

  def workers_health
    begin
      stats = Sidekiq::Stats.new
      {
        status: :ok,
        stats: {
          failed: stats.failed,
          retries: stats.retry_size,
          processes: stats.processes_size,
          enqueued: stats.enqueued,
          queues: sk_queue_sizes
        }
      }
    rescue StandardError => error
      { status: :error, error: error.inspect }
    end
  end

  def sk_queue_sizes
    Sidekiq::Queue.all.each_with_object({}) do |queue, total|
      total[queue.name] = queue.size
    end
  end
end
