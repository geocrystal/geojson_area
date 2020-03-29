# Ported from JS library [geojson-area](https://github.com/mapbox/geojson-area)
module GeoJSON
  # Calculate the area inside of any GeoJSON geometry.
  module Area
    extend self

    # https://en.wikipedia.org/wiki/World_Geodetic_System#WGS84
    EARTH_RADIUS = 6378137

    # Given a Geometry object, return contained area as square meters.
    def area(object : GeoJSON::Object) : Float64
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

    private def polygon_area(coordinates) : Float64
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

    # Calculate the approximate area of the polygon in square meters were it projected onto the earth
    # Note that this area will be positive if ring is oriented clockwise, otherwise it will be negative.
    #
    # Reference:
    #
    #   Robert. G. Chamberlain and William H. Duquette, "Some Algorithms for Polygons on a Sphere",
    #   JPL Publication 07-03, Jet Propulsion Laboratory, Pasadena, CA, June 2007
    #   http://trs-new.jpl.nasa.gov/dspace/handle/2014/40409
    #
    private def ring_area(coordinates) : Float64
      area = 0
      coordinates_length = coordinates.size

      coordinates.each_with_index do |_, i|
        if i == coordinates_length - 2 # i = N-2
          lower_index = coordinates_length - 2
          middle_index = coordinates_length - 1
          upper_index = 0
        elsif i == coordinates_length - 1 # i = N-1
          lower_index = coordinates_length - 1
          middle_index = 0
          upper_index = 1
        else # i = 0 to N-3
          lower_index = i
          middle_index = i + 1
          upper_index = i + 2
        end

        p1 = coordinates[lower_index]
        p2 = coordinates[middle_index]
        p3 = coordinates[upper_index]

        area += (rad(p3.longitude) - rad(p1.longitude)) * Math.sin(rad(p2.latitude))
      end

      area * EARTH_RADIUS * EARTH_RADIUS / 2
    end

    private def rad(n)
      n * Math::PI / 180
    end
  end
end
