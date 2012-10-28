# Inspiration:
#   http://openmonkey.com/blog/2008/10/23/using-markov-chains-to-provide-english-language-seed-data-for-your-rails-application/
#   by Tim Riley
# by Shane Brinkman-Davis

module LiterateRandomizer
class MarkovChain
  DEFAULT_PUNCTUATION_DISTRIBUTION = %w{. . . . . . . . . . . . . . . . ? !}
  PREPOSITION_REGEX = /^(had|the|to|or|and|a|in|that|it|if|of|is|was|for|on|as|an|your|our|my|per|until)$/

  # The source of all random values. Must implement: #rand(limit)
  #
  # Default: Random.new()
  attr_accessor :randomizer

  # To end setences, one of the strings in this array is selected at random (uniform-distribution)
  #
  # Default: DEFAULT_PUNCTUATION_DISTRIBUTION
  attr_accessor :punctuation_distribution

  # A hash (string => true) of all unique words found in the source-material.
  attr_reader :words

  # An array of all words that appear at the beginning of sentences in the source-material.
  attr_reader :first_words

  # Data structure incoding all Markov-Chains (bi-grams) found in the source-material.
  attr_reader :markov_chains

  private

  # cached copy of the options passed in on initialization
  attr_accessor :init_options

  def default_source_material
    File.expand_path File.join(File.dirname(__FILE__),"..","..","data","the_lost_world_by_arthur_conan_doyle.txt")
  end

  # options:
  #     :source_material => string
  #     :source_material_file => filename
  def source_material(options=init_options)
    options[:source_material] || File.read(options[:source_material_file] || default_source_material)
  end

  # add a word/next_word pair to @markov_chains
  def chain_add(word, next_word)
    markov_chains[word] ||= Hash.new(0)
    markov_chains[word][next_word] += 1
  end

  # remove any non-alpha characters from word
  def scrub_word(word)
    word &&= word[/[A-Za-z][A-Za-z'-]*/]
    word &&= word[/[A-Za-z'-]*[A-Za-z]/]
    (word && word.strip) || ""
  end

  # clean up all words in  a string, returning an array of clean words
  def scrub_sentence(sentence)
    sentence.split(/[\s]+/).collect {|a| scrub_word(a)}.select {|a| a.length>0}
  end

  # return word with the first letter capitalized
  def capitalize(word)
    word.chars.first.upcase+word[1..-1]
  end

  def source_sentences
    source_material.split(/([.?!"]\s|--| ')+/)
  end

  # remove all dead-end words
  def prune_markov_words
    @markov_chains.keys.each do |key|
      @markov_key.delete(key) if @markov_chains[key].length == 0
    end
  end

  def populate_markov_words
    @markov_chains = {}
    @words = {}
    @first_words = {}
    source_sentences.each do |sentence|
      word_list = scrub_sentence sentence
      @first_words[word_list[0]] = true
      word_list.each_with_index do |word, index|
        @words[word] = true
        next_word = word_list[index+1]
        chain_add word, next_word if next_word
      end
    end
    prune_markov_words
  end

  def populate_markov_sum
    @markov_weighted_sum = {}
    @markov_chains.each do |word,followers|
      @markov_weighted_sum[word] = followers.inject(0) {|sum,kv| sum + kv[1]}
    end
  end

  def populate
    populate_markov_words
    populate_markov_sum
  end

  # r can be an Integer of a Range. If an intenger, return r, else, return a the maximum value in the range.
  def max(r)
    return r if r.kind_of? Integer
    r.max
  end

  # r can be an Integer of a Range. If an intenger, return r, else, return a random number within the range.
  def rand_count(r)
    return r if r.kind_of? Integer
    rand(r.max-r.min)+r.min
  end

  def next_word(word)
    return if !markov_chains[word]
    sum = @markov_weighted_sum[word]
    random = rand(sum)+1
    partial_sum = 0
    (markov_chains[word].find do |w, count|
      partial_sum += count
      w!=word && partial_sum >= random
    end||[]).first
  end

  def extend_trailing_preposition(max_words,words)
    while words.length < max_words && words[-1] && words[-1][PREPOSITION_REGEX]
      words << next_word(words[-1])
    end
    words
  end

  public
  # Create a new instance. Each Markov randomizer instance can run against its own source_material.
  #
  # Options:
  #
  # * :source_material => string OR
  # * :source_material_file => filename
  # * :randomizer => Random.new # must respond to #rand(limit)
  # * :punctuation_distribution => DEFAULT_PUNCTUATION_DISTRIBUTION #punctiation is randomly selected from this array
  def initialize(options={})
    @init_options = options
    @randomizer = randomizer || Random.new
    @punctuation_distribution = options[:punctuation_distribution] || DEFAULT_PUNCTUATION_DISTRIBUTION

    populate
  end

  # Returns a quick summary of the instance.
  def inspect
    "#<#{self.class}: #{@words.length} words, #{@markov_chains.length} word-chains, #{@first_words.length} first_words>"
  end

  # return a random word
  def word
    @cached_word_keys ||= words.keys
    @cached_word_keys[rand(@cached_word_keys.length)]
  end

  # return a random first word of a sentence
  def first_word
    @cached_first_word_keys ||= first_words.keys
    @cached_first_word_keys[rand(@cached_first_word_keys.length)]
  end

  # return a random first word of a sentence
  def markov_word
    @cached_markov_word_keys ||= markov_chains.keys
    @cached_markov_word_keys[rand(@cached_markov_word_keys.length)]
  end

  # return a random number generated by randomizer
  def rand(limit=nil)
    @randomizer.rand(limit)
  end

  # return a random end-sentence string from punctuation_distribution
  def punctuation
    @punctuation_distribution[rand(@punctuation_distribution.length)]
  end

  # return a random sentence
  #
  # Options:
  #
  # * :first_word => nil - the start word
  # * :words => range or int - number of words in sentence
  # * :punctuation => nil - punction to end the sentence with (nil == randomly selected from punctuation_distribution)
  def sentence(options={})
    word = options[:first_word] || self.markov_word
    num_words_option = options[:words] || (3..15)
    count = rand_count num_words_option
    punctuation = options[:punctuation] || self.punctuation

    words = count.times.collect do
      word.tap {word = next_word(word)}
    end.compact

    words = extend_trailing_preposition(max(num_words_option), words)

    capitalize words.compact.join(" ") + punctuation
  end

  # return a random paragraph
  #
  # Options:
  #
  # * :first_word => nil - the first word of the paragraph
  # * :words => range or int - number of words in sentence
  # * :sentences => range or int - number of sentences in paragraph
  # * :punctuation => nil - punction to end the paragraph with (nil == randomly selected from punctuation_distribution)
  def paragraph(options={})
    count = rand_count options[:sentences] || (5..15)

    count.times.collect do |i|
      op = options.clone
      op.delete :punctuation unless i==count-1
      op.delete :first_word unless i==0
      sentence op
    end.join(" ")
  end

  # return random paragraphs
  #
  # Options:
  #
  # * :first_word => nil - the first word of the paragraph
  # * :words => range or int - number of words in sentence
  # * :sentences => range or int - number of sentences in paragraph
  # * :paragraphs => range or int - number of paragraphs in paragraph
  # * :join => "\n\n" - join the paragraphs. if :join => false, returns an array of the paragraphs
  # * :punctuation => nil - punction to end the paragraph with (nil == randomly selected from punctuation_distribution)
  def paragraphs(options={})
    count = rand_count options[:paragraphs] || (3..5)
    join_str = options[:join]

    res = count.times.collect do |i|
      op = options.clone
      op.delete :punctuation unless i==count-1
      op.delete :first_word unless i==0
      paragraph op
    end

    join_str!=false ? res.join(join_str || "\n\n") : res
  end
end
end
