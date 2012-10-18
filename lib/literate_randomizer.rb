%w{version markov}.each do |file|
  require File.join(File.dirname(__FILE__),"literate_randomizer", file)
end

module LiterateRandomizer

  def LiterateRandomizer::create(options={})
    MarkovChain.new options
  end
end
