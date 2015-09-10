require 'rgeo/geo_json'

class ListsController < ApplicationController
  def index
    if params[:street].present?
      @lists = List.where(street: params[:street])
    else
      @lists = List.all

    end
     @list = List.find(1)
     newlist = @list.to_json
     newlist.delete("lat")
     newlist.delete("lng")
     feature = {}
     feature["type"] = "feature"
    #  feature["geometry"] = {"type": "Point"}
     feature["properties"] = newlist

     @allfeature = {}
     @allfeature["type"] = "FeatureCollection"
     @allfeature["features"] = [feature]
    # @list = "#{@list}"
    @allfeature = RGeo::GeoJSON.decode(@allfeature, :json_parse => :json)
    @allfeature.as_text
    # str1 = '{"type":"Point","coordinates":[1,2]}'
    # @list = RGeo::GeoJSON.decode(str1, :json_parser => :json)

  end

  def import
    List.import(params[:file])
    redirect_to root_url, notice: "Lists imported."
  end



end
