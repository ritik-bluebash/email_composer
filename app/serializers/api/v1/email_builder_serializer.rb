module Api
  module V1
    class EmailBuilderSerializer
      include JSONAPI::Serializer

      attributes :category, :topic, :tone, :additional_note, :result
      set_id :id

      attribute :id do |id|
        nil
      end
    end
  end
end
