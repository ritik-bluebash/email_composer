module Api
  module V1
    class EmailController < BaseController
      def generate
        email_builder = EmailBuilder.new(permitted_params)
        if email_builder.valid?
          result = email_composer_service.call(email_builder:)
          render_result(result)
        else
          render_error_payload(email_builder)
        end
      end

      private

      def email_composer_service
        ::OpenAI::EmailComposer.new
      end

      def resource_serializer
        ::Api::V1::EmailBuilderSerializer
      end

      def permitted_params
        params.require(:email_builder).permit!
      end
    end
  end
end
