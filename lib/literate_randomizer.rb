%w{
  version
  util
  source_parser
  markov
  randomizer
}.each {|file|require File.join(File.dirname(__FILE__),"literate_randomizer", file)}

module LiterateRandomizer

  class << self

    # Create a new Randomizer instance
    #
    # See LiterateRandomizer::Randomizer#initializer for options.
    def create(options={})
      Randomizer.new options
    end

    # Access or initialize the global randomizer instance.
    #
    # The first time this is called, the global instance is created and initialized. Subsequent calls with no parameters just return
    # the global instance. If LiterateRandomize.global is called again with options, a new global instance is created.
    #
    # See LiterateRandomizer::Randomizer#initializer for options.
    def global(options=nil)
      return @global_instance if @global_instance && !options
      @global_instance ||= Randomizer.new(options||{})
    end

    # Forwards method invocations to the global Randomizer instance. Unless you need more than one instance of Randomizer,
    # this is the easiest way to use LiterateRandomizer.
    #
    # Examples:
    #
    # * LiterateRandomizer.word
    # * LiterateRandomizer.sentence
    # * LiterateRandomizer.paragraph
    # * LiterateRandomizer.paragraphs
    def method_missing(method, *arguments, &block)
      global.send(method, *arguments, &block)
    end

    # correctly mirrors method_missing
    def respond_to?(method)
      super || global.respond_to?(method)
    end
  end
end
