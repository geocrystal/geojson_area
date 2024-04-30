# Ported from JS library [geojson-area](https://github.com/mapbox/geojson-area)
module GeoJSON
  # Calculate the area inside of any GeoJSON geometry.
  module Area
    extend self

    # Given a Geometry object, return contained area as square meters.
    def area(object : GeoJSON::Object) : Float32 | Float64
      case object
      when GeoJSON::Polygon
        polygon_area(object.coordinates)
      when GeoJSON::MultiPolygon
        object.coordinates.reduce(0.0) do |area, coordinates|
          area + polygon_area(coordinates)
        end
      when GeometryCollection
        object.geometries.reduce(0.0) do |area, geometry|
          area + area(geometry)
        end
      else
        0.0
      end
    end

    private def polygon_area(coordinates) : Float32 | Float64
      coordinates.each_with_index.reduce(0.0) do |area, (ring, i)|
        if i == 0
          # exterior ring
          area + ring_area(ring).abs
        else
          # interior rings
          area - ring_area(ring).abs
        end
      end
    end

    private def ring_area(coordinates) : Float32 | Float64
      coords = coordinates.map { |coordinate| [coordinate.longitude, coordinate.latitude] }

      RingArea.ring_area(coords).to_meters
    end
  end
end
