module Api
  module V1
    class BaseController < ActionController::API
      rescue_from ActionController::ParameterMissing, with: :error_during_processing
      rescue_from ArgumentError, with: :error_during_processing
      rescue_from ActionDispatch::Http::Parameters::ParseError, with: :error_during_processing

      def content_type
        'application/vnd.api+json'
      end

      protected

      def serialize_resource(resource)
        resource_serializer.new(
          resource
        ).serializable_hash
      end

      def render_serialized_payload(status = 200)
        render json: yield, status: status, content_type: content_type
      end

      def render_error_payload(error, status = 422)
        json = if error.is_a?(ActiveModel::Errors)
                 { error: error.full_messages.to_sentence, errors: error.messages }
               elsif error.is_a?(Struct)
                 { error: error.to_s, errors: error.to_h }
               else
                 { error: error }
               end

        render json: json, status: status, content_type: content_type
      end

      def render_result(result, ok_status = 200)
        if result.success?
          render_serialized_payload(ok_status) { serialize_resource(result.value) }
        else
          render_error_payload(result.error)
        end
      end

      def error_during_processing(exception)
        result = error_handler.call(exception: exception, opts: {})

        render_error_payload(result.value[:message], 400)
      end

      def error_handler
        ::Api::ErrorHandler.new
      end
    end
  end
end
