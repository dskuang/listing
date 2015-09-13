require 'rgeo/geo_json'
require "yaml"

class ListsController < ApplicationController
  def index
      @allfeatures = {}
      @allfeatures["type"] = "FeatureCollection"
      @allfeatures["features"] = []
      hash = {}
      query_string = []
      query_values = []

      if (params[:min_bed] != "" && params[:max_bed] != "")
        query_string << "bedrooms between ? and ?"
        query_values << params[:min_bed]
        query_values << params[:max_bed]
      elsif params[:min_bed] != ""
        query_string << "bedrooms >= ?"
        query_values << params[:min_bed]
      elsif params[:max_bed] != ""
        query_string << "bedrooms <= ?"
        query_values << params[:max_bed]
      end

      if (params[:min_price] != "" && params[:max_price] != "")
        query_string << "price between ? and ?"
        query_values << params[:min_price]
        query_values << params[:max_price]
      elsif params[:min_price] != ""
        query_string << "price >= ?"
        query_values << params[:min_price]
      elsif params[:max_price] != ""
        query_string << "price <= ?"
        query_values << params[:max_price]
      end

      if(params[:min_sq_ft] != "" && params[:max_sq_ft] != "")
        query_string << "sq_ft between ? and ?"
        query_values << params[:min_sq_ft]
        query_values << params[:max_sq_ft]
      elsif params[:min_sq_ft] != ""
        query_string << "sq_ft >= ?"
        query_values << params[:min_sq_ft]
      elsif params[:max_sq_ft] != ""
        query_string << "sq_ft <= ?"
        query_values << params[:max_sq_ft]
      end

      if (params[:min_bath] != "" && params[:max_bath] != "")
        query_string << "bathrooms between ? and ?"
        query_values << params[:min_bath]
        query_values << params[:max_bath]
      elsif params[:min_bath] != ""
        query_string << "bathrooms >= ?"
        query_values << params[:min_bath]
      elsif params[:max_bath] != ""
        query_string << "bathrooms <= ?"
        query_values << params[:max_bath]
      end

      if(params[:status] != "")
        query_string << "status = ?"
        query_values << params[:status]
      end

      if(params[:street] != "")
        query_string << "street = ?"
        query_values << params[:street]
      end

      @lists = List.where(query_string.join(" AND "), *query_values)
              .page(params[:page].to_i)
              .per(10)
      @allfeatures["total_pages"] = @lists.total_pages
      @lists.each do |list|
        newlist = list.attributes
        newlist.delete("lat")
        newlist.delete("lng")
        newlist.delete("updated_at")
        newlist.delete("created_at")
        newlist["marker-size"] = "medium"
        newlist["marker-color"] = "#fc4353"
        newlist["marker-symbol"] = "building"
        feature = {}
        feature["type"] = "Feature"
        feature["geometry"] = {"type" => "Point", "coordinates" => [list.lng, list.lat]}
        feature["properties"] = newlist
        @allfeatures["features"] << feature
      end

      respond_to do |format|
        format.html
        format.json { render json: @allfeatures }
      end
  end

  def import
    List.import(params[:file])
    redirect_to root_url, notice: "Lists imported."
  end

end
