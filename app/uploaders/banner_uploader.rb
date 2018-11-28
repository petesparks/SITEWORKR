class BannerUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  def default_url
    "http://physiciantechpartners.com/wp-content/uploads/2016/02/orange-wave.png"
  end
end
