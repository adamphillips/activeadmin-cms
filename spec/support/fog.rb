# Puts fog into S3 mock mode

unless Kernel.const_defined?("S3_CONFIG")
  S3_CONFIG = YAML.load_file("#{Rails.root}/config/s3.yml")[Rails.env].try(:symbolize_keys)
end

Fog.mock!

connection = ::Fog::Storage.new(
        :aws_access_key_id      => S3_CONFIG[:access_key_id],
        :aws_secret_access_key  => S3_CONFIG[:secret_access_key],
        :provider               => 'AWS',
        :region                 => "us-east-1"
      )

connection.directories.create(:key => S3_CONFIG[:bucket])


