# GeoJSON::Area

[![License](https://img.shields.io/github/license/geocrystal/geojson_area.svg)](https://github.com/geocrystal/geojson_area/blob/master/LICENSE)

Calculate the area inside of any [GeoJSON](https://github.com/geocrystal/geojson) geometry.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     geojson_area:
       github: geocrystal/geojson_area
   ```

2. Run `shards install`

## Usage

```crystal
require "geojson_area"
```

This adds `area` method for all `GeoJSON` objects:

```crystal
polygon = GeoJSON::Polygon.new([
  [[-10.0, -10.0], [10.0, -10.0], [10.0, 10.0], [-10.0,-10.0]],
  [[-1.0, -2.0], [3.0, -2.0], [3.0, 2.0], [-1.0,-2.0]]
])

polygon.area
# => 2366726096087.807
```

Also you can use `GeoJSON::Area.area()` directly.
This method accept any `GeoJSON` object, and returns contained area as square meters.

```crystal
polygon = GeoJSON::Polygon.new([
  [[-10.0, -10.0], [10.0, -10.0], [10.0, 10.0], [-10.0,-10.0]],
  [[-1.0, -2.0], [3.0, -2.0], [3.0, 2.0], [-1.0,-2.0]]
])

GeoJSON::Area.area(polygon)
# => 2366726096087.807
```

## Contributing

1. Fork it (<https://github.com/geocrystal/geojson_area/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Anton Maminov](https://github.com/mamantoha) - creator and maintainer
