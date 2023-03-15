module OpenAI
  class EmailComposer
    prepend ::ServiceModule::Base

    attr_reader :client

    def initialize
      @client = OpenAI::Client.new
    end

    def call(email_builder:)
      run :execute
    end

    private

    def execute(email_builder:)
      response = client.chat(
          parameters: {
              model: model_name,
              messages: [{ role: "user", content: email_builder.prepare_context! }],
              temperature: 0.7,
          })

      if response.dig("error").present?
        email_builder.errors.add(:base, response.dig("error", "message"))
        return failure(email_builder)
      end

      data = response.dig("choices", 0, "message", "content")
      email_builder.assign_attributes(result: data)

      success(email_builder)
    end

    def model_name
      "gpt-3.5-turbo".freeze
    end
  end
end
