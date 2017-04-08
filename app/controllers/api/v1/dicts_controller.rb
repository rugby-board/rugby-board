module Api
  module V1
    class DictsController < Api::V1::BaseController
      def show
        require "rugby-dict"
        input = params[:entry]
        dict = RugbyDict::Dict.from_yaml
        names = RugbyDict::Dict.segment(input)
        result = dict.query_dict(names)

        respond_with result: result
      end
    end
  end
end
