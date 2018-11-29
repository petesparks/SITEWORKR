class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  def default_url
    "https://res.cloudinary.com/lwsw18ldn/image/upload/v1543498139/euzb3pyrhk5i55zydztj.svg"
  end
end
