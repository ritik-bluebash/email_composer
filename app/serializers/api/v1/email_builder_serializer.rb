module Api
  module V1
    class EmailBuilderSerializer
      include JSONAPI::Serializer

      attributes :category, :topic, :tone, :additional_comment, :result

      # attribute :result do |email|
      #   email.result.html_safe
      # end
    end
  end
end
