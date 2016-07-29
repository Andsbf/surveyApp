module Predicate
  class Base
    attr_reader :name, :type

    def initialize(name, type)
      @name = name
      @type = type
    end

    def self.supported
      [
        Predicate::Attribute.new(:email,         :string),
        Predicate::Attribute.new(:first_name,    :string),
        Predicate::Attribute.new(:last_name,     :string),
        Predicate::Attribute.new(:age,           :integer),
        Predicate::Attribute.new(:city,          :string),
        Predicate::Attribute.new(:country,       :string),
        Predicate::Attribute.new(:gender,        :string),
        Predicate::Attribute.new(:company,       :string),
        Predicate::Attribute.new(:participated,  :string),
        Predicate::Attribute.new(:visited_url,   :string)
      ]
    end

    def self.sample
      supported.sample
    end
  end

  class Event < Predicate::Base
    def match_type
      :event
    end
  end

  class Attribute < Predicate::Base
    def match_type
      :attribute
    end
  end
end
