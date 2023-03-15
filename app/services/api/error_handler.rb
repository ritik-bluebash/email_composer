module Api
  class ErrorHandler
    prepend ::ServiceModule::Base

    def call(exception:, opts: {})
      run :format_message
      run :log_error
      run :report_error
    end

    protected

    def format_message(exception:, opts:)
      message = if exception.respond_to?(:original_message)
                  exception.original_message
                else
                  exception.message
                end

      success(exception:, message:, opts:)
    end

    def log_error(exception:, message:, opts:)
      Rails.logger.error message
      Rails.logger.error exception.backtrace.join("\n")

      success(exception:, message:, opts:)
    end

    def report_error(exception:, message:, opts:)
      # overwrite this method in your application to support different error handlers
      # eg. Sentry, Rollbar, etc

      success(exception:, message:)
    end
  end
end
