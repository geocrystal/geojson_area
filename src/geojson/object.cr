module GeoJSON
  class Object
    def area : Float64
      GeoJSON::Area.area(self)
    end
  end
end
