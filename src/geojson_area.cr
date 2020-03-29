require "geojson"
require "./geojson/area"

module GeoJSON::Area
  VERSION = {{ `shards version #{__DIR__}`.chomp.stringify }}
end
