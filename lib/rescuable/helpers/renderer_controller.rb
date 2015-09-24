module Rescuable
  module Helpers
    module RendererController
      extend ActiveSupport::Concern

      class_methods do
        def rescuable_error(error, status)
          Error.statuses.merge!(error.to_sym => status)
        end
      end

      protected

      def error_renderer(error)
        render json: error.to_json, status: error.status
      end

      def render_error(error, **args)
        error = Error.new(error, **args) unless error.respond_to?(:to_error)
        error = error.to_error
        error_renderer error
      end

      def render_record_error(record)
        render_error RecordError.new(record)
      end
    end
  end
end
