module Api
  module V1
    class EmailController < BaseController

      def generate
        response = email_composer_service.call(permitted_params)
        render_result(response)
      end

      private

      def email_composer_service
        ::OpenAI::EmailComposer.new
      end

      def permitted_params
        params.require(:email_builder).permit!
      end
    end
  end
end
