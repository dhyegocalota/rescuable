module Rescuable
  class RecordError
    attr_accessor :record

    def initialize(record)
      @record = record
    end

    def to_error
      Error.new(:invalid_record, message: record.errors.full_messages.first)
    end
  end
end
