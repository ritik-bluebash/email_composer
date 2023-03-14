module OpenAI
  class EmailComposer
    prepend ::ServiceModule::Base

    attr_reader :client, :resource_klass

    def initialize
      @client = OpenAI::Client.new
      @resource_klass = EmailBuilder.new
    end

    def call(params:)
      run :prepare_context
      run :execute
    end

    private

    def execute(params:)
      response = client.chat(
          parameters: {
              model: model_name,
              messages: [{ role: "user", content: prepare_context }],
              temperature: 0.7,
          })

      if response.dig("error").present?
        resource_klass.errors.add(:base, response.dig("error", "message"))
        return failure(resource_klass)
      end

      data = response.dig("choices", 0, "message", "content")
      resource_klass.assign_attributes(result: data)

      success(resource_klass)
    end

    def prepare_context(params:)
      resource_klass.assign_attributes(params)
      response_klass.formatted_text!
    end

    def model_name
      "gpt-3.5-turbo".freeze
    end
  end
end
