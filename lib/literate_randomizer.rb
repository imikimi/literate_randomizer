%w{version markov}.each do |file|
  require File.join(File.dirname(__FILE__),"literate_randomizer", file)
end

module LiterateRandomizer

  class << self
    def create(options={})
      MarkovChain.new options
    end

    def global(options={})
      @global_instance ||= MarkovChain.new options
    end

    def method_missing(method, *arguments, &block)
      global.send(method, *arguments, &block)
    end

    def respond_to?(method)
      super || global.respond_to?(method)
    end
  end
end
