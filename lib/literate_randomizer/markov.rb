# Inspiration:
#   http://openmonkey.com/blog/2008/10/23/using-markov-chains-to-provide-english-language-seed-data-for-your-rails-application/
#   by Tim Riley
# by Shane Brinkman-Davis

module LiterateRandomizer

# The Markov-Chain bi-gram model. Primary purpose is, given a word, return the next word that is "likely" based on the source material.
class MarkovModel

  # The source of all random values. Must implement: #rand(limit)
  #
  # Default: Random.new()
  attr_accessor :randomizer

  # A hash (string => true) of all unique words found in the source-material.
  attr_reader :words

  # An array of all words that appear at the beginning of sentences in the source-material.
  attr_reader :first_words

  # Data structure incoding all Markov-Chains (bi-grams) found in the source-material.
  #
  # markov_chains is a hash of hashs. The top level keys are the "first words" in the chain.
  # For each first-word, there are one or more words that followed that word in the text. Second-words are the second-level hash key.
  # The second-level hash values are the count of the number of times that second word followed the first.
  #
  # Summary: {first_words => {second_words => found-in-source-material-in-sequence-count}}
  attr_reader :markov_chains

  # an instance of SourceParser attached to the source_material
  attr_accessor :source_parser

  private

  # cached copy of the options passed in on initialization
  attr_accessor :init_options

  # add a word/next_word pair to @markov_chains
  def chain_add(word, next_word)
    markov_chains[word] ||= Hash.new(0)
    markov_chains[word][next_word] += 1
  end

  # remove all dead-end words
  def prune_markov_words
    @markov_chains.keys.each do |key|
      @markov_key.delete(key) if @markov_chains[key].length == 0
    end
  end

  # populate the @markov_chains hash
  def populate_markov_chains
    @markov_chains = {}
    @words = {}
    @first_words = {}
    source_parser.each_sentence do |word_list|
      next unless word_list.length >= 2
      @first_words[word_list[0]] = true
      word_list.each_with_index do |word, index|
        @words[word] = true
        next_word = word_list[index+1]
        chain_add word, next_word if next_word
      end
    end
    prune_markov_words
  end

  # populate the weight-sums for each chain
  # (an optimization)
  def populate_markov_sum
    @markov_weighted_sum = {}
    @markov_chains.each do |word,followers|
      @markov_weighted_sum[word] = followers.inject(0) {|sum,kv| sum + kv[1]}
    end
  end

  # Populate internal data-structures in preparation for #next_word
  def populate
    populate_markov_chains
    populate_markov_sum
  end

  public
  # Initialize a new instance.
  #
  # Options:
  #
  # * :randomizer => Random.new # must respond to #rand(limit)
  # * :source_parser => SourceParser.new options
  def initialize(options={})
    @randomizer = randomizer || Random.new
    @source_parser = options[:source_parser] || SourceParser.new(options)

    populate
  end

  # Given a word, return a weighted-randomly selected next-one.
  def next_word(word,randomizer=@randomizer)
    return if !markov_chains[word]
    sum = @markov_weighted_sum[word]
    random = randomizer.rand(sum)+1
    partial_sum = 0
    (markov_chains[word].find do |w, count|
      partial_sum += count
      w!=word && partial_sum >= random
    end||[]).first
  end
end
end
