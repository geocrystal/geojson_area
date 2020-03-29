require "geojson"
require "./geojson/area"
require "./geojson/object"

module GeoJSON::Area
  VERSION = {{ `shards version #{__DIR__}`.chomp.stringify }}
end
