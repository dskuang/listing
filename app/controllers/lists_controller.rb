require 'rgeo/geo_json'
require "yaml"

class ListsController < ApplicationController
  def index
    if params[:list].present?
      @lists = List.where(bedrooms: params[:list][:min_bed]..params[:list][:max_bed]).to_json

    else
      @lists = List.all
      @list = List.find(1)
      if @list
        newlist = @list.attributes
        newlist.delete("lat")
        newlist.delete("lng")
        newlist.delete("updated_at")
        newlist.delete("created_at")
        newlist["marker-size"] = "large"
        newlist["marker-color"] = "#fc4353"
        newlist["marker-symbol"] ="monument"
        feature = {}
        feature["type"] = "Feature"
        feature["geometry"] = {"type" => "Point", "coordinates" => [@list.lat, @list.lng]}
        feature["properties"] = newlist

        @allfeature = {}
        @allfeature["type"] = "FeatureCollection"
        @allfeature["features"] = [feature]
        respond_to do |format|
          format.html
          format.json { render json: @allfeature }  # respond with the created JSON object
        end
      end
    end
  end

  def import
    List.import(params[:file])
    redirect_to root_url, notice: "Lists imported."
  end

end
