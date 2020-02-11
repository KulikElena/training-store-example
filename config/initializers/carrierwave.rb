CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_credentials = {
      provider: :aws,
      aws_access_key_id: ENV['S3_ACCESS_KEY'],
      aws_secret_access_key: ENV['S3_SECRET_KEY'],
      region: ENV['S3_REGION'],
      endpoint: ENV['S3_ENDPOINT']
    }
    config.fog_directory = ENV['S3_BUCKET_NAME']
    config.storage = :fog
  else
    config.storage = :file
  end
end
