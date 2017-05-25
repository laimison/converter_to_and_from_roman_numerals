module Services
  class BaseService
    attr_reader :record, :errors, :results

    # Handy class method that should only be used to do single tasks which either return an object or boolean.
    #   Ex: when you don't expect a result object do
    #         Services::SomeService.new(record, option).perform
    #   Ex: when you  expect a result object
    #         service_object = Services::SomeService.new(record, option)
    #         service_object.perform
    #         service_object.results
    # The service object is designed to return a collection of error messages.
    # Ex: when you want to only print and error
    #
    #   Ex: some_service_object = Services::SomeService.new(record, option)
    #       if some_service_object.perform
    #         do_something
    #       else
    #         puts some_service_object.error_messages
    #       end

    def self.perform(*args)
      new(*args).perform
    end

    def initialize(record, options = {})
      @record  = record
      @options = options

      @performed = false
      @errors = []
      @results = []
    end

    def perform
      if allow?
        perform_if_allowed
      else
        perform_if_not_allowed
      end

      @performed = true
      success?
    end

    def performed?
      @performed
    end

    def success?
      @performed && @errors.any?
    end

    def error_messages
      @errors.join(', ')
    end

    def perform_if_not_allowed
      @errors << "#{self.class.name}: Did not allow to perform"
    end

  end # END class
end # END module