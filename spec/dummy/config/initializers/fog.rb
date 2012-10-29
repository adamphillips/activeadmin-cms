CarrierWave.configure do |config|
   config.fog_credentials = {
     :provider               => 'AWS',
     :aws_access_key_id      => 'AKIAIQ3XZ7WQBPMW3Q6A',
     :aws_secret_access_key  => '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',
     :region => 'eu-west-1'
   }
   config.asset_host  = '//dev.aacms.s3.amazonaws.com'
   config.fog_directory  = 'dev.aacms'
 end


