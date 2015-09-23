module Rescuable
  class Error
    include ActiveModel::Serializers::JSON

    DEFAULT_ERROR_MESSAGE = 'Something went wrong'.freeze

    cattr_accessor :statuses
    @@statuses = Hash.new(:internal_server_error)
    @@statuses.merge!(
      invalid_record: :unprocessable_entity
    )

    attr_accessor :id, :message, :status

    def initialize(id, options = {})
      @id = id
      @message = options[:message]
      @status = options[:status]
    end

    def status
      @status || @@statuses[@id]
    end

    def message
      @message || I18n.t(@id, :default => [:default, DEFAULT_ERROR_MESSAGE], :scope => 'rescuable.errors.messages')
    end

    def attributes
      {
        id: id,
        message: message
      }.with_indifferent_access
    end

    def to_error
      self
    end
  end
end
