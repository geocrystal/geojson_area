require "./spec_helper"

describe GeoJSON::Area do
  illinois_file = File.read("#{__DIR__}/fixtures/illinois.json")
  all_file = File.read("#{__DIR__}/fixtures/all.json")

  illinois_area = 145978332359.36746
  all_area = 511207893395811.06

  it "computes the area of illinois" do
    object = GeoJSON::Object.from_json(illinois_file)

    object.should be_a(GeoJSON::MultiPolygon)

    area = GeoJSON::Area.area(object)
    area.should eq(illinois_area)
  end

  it "computes the area of the world" do
    object = GeoJSON::Object.from_json(all_file)

    object.should be_a(GeoJSON::Polygon)

    area = GeoJSON::Area.area(object)
    area.should eq(all_area)
  end

  it "computes the area of geocollection as the sum" do
    all = GeoJSON::Object.from_json(all_file)
    illinois = GeoJSON::Object.from_json(illinois_file)

    object = GeoJSON::GeometryCollection.new([all, illinois])
    area = GeoJSON::Area.area(object)

    area.should eq(all_area + illinois_area)
  end

  it "point has zero area" do
    point = GeoJSON::Point.new([0.0, 0.0])
    area = GeoJSON::Area.area(point)

    area.zero?.should be_truthy
  end

  it "linestring has zero area" do
    line_string = GeoJSON::LineString.new([[0.0, 0.0], [1.0, 1.0]])
    area = GeoJSON::Area.area(line_string)

    area.zero?.should be_truthy
  end
end
