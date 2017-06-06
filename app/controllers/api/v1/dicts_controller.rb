module Api
  module V1
    class DictsController < Api::V1::BaseController
      def show
        require "rugby-dict"
        input = params[:entry]
        dict = RugbyDict::Dict.from_yaml
        names = RugbyDict::Dict.segment(input)

        query_result = []
        names.each do |word|
          t = dict.query_dict(word)
          query_result << t unless t.nil?
        end

        result = {
          :result => query_result
        }

        render json: result
      end
    end
  end
end
