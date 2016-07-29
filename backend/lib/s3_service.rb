class S3Service
  CSV_BUCKET_NAME = 'jambo.csv.uploads'.freeze
  DEFAULT_ACL = 'authenticated-read'.freeze

  def initialize(merchant: nil, bucket_name: nil)
    @merchant = merchant
    @bucket_name = bucket_name || CSV_BUCKET_NAME
  end

  def upload(file, key: nil, upload_options: {})
    options = upload_options.reverse_merge!(default_upload_options)
    object(key).upload_file(file, options)
    object
  end

  def default_upload_options
    { acl: DEFAULT_ACL }.merge!(metadata)
  end

  def get_object(key)
    client.get_object(bucket: @bucket_name, key: key)
  end

  def object(key = nil)
    @object ||= bucket.object(key || generate_key)
  end

  def bucket
    @bucket ||= resource.bucket(@bucket_name)
  end

  def resource
    @resource ||= Aws::S3::Resource.new
  end

  def client
    @client ||= Aws::S3::Client.new
  end

  private

  def metadata
    {
      metadata: {
        mid: @merchant.id,
        env: Rails.env.to_s
      }
    }
  end

  def generate_key
    SecureRandom.hex(24)
  end
end
