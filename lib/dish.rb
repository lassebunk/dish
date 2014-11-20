%w{
  version
  plate
  helper
  deprecated/as_hash
}.each do |f|
  require "dish/#{f}"
end