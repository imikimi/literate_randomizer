#source: http://openmonkey.com/blog/2008/10/23/using-markov-chains-to-provide-english-language-seed-data-for-your-rails-application/
# Tim Riley
# Gemified by Shane Brinkman-Davis

module LiterateRandomizer
class MarkovChain
  attr_accessor :randomizer, :init_options, :punctuation_distribution
  attr_reader :markov_words, :words, :first_words

  def default_source_material
    File.expand_path File.join(File.dirname(__FILE__),"..","..","data","the_lost_world_by_arthur_conan_doyle.txt")
  end

  # options:
  #     :source_material => string
  #     :source_material_file => filename
  def source_material(options=init_options)
    options[:source_material] || File.read(options[:source_material_file] || default_source_material)
  end


  def chain_add(word, next_word)
    markov_words[word] ||= Hash.new(0)
    markov_words[word][next_word] += 1
  end

  # remove any non-alpha characters from word
  def scrub_word(word)
    word &&= word[/[A-Za-z][A-Za-z'-]*/]
    word &&= word[/[A-Za-z'-]*[A-Za-z]/]
    (word && word.strip) || ""
  end

  def scrub_word_list(word_list)
    word_list.split(/[\s]+/).collect {|a| scrub_word(a)}.select {|a| a.length>0}
  end

  def capitalize(word)
    word.chars.first.upcase+word[1..-1]
  end

  def source_sentances
    source_material.split(/([.?!"]\s|--| ')+/)
  end

  # remove all dead-end words
  def prune_markov_words
    @markov_words.keys.each do |key|
      @markov_key.delete(key) if @markov_words[key].length == 0
    end
  end

  def populate_markov_words
    @markov_words = {}
    @words = {}
    @first_words = {}
    source_sentances.each do |sentance|
      word_list = scrub_word_list sentance
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
    @markov_words.each do |word,followers|
      @markov_weighted_sum[word] = followers.inject(0) {|sum,kv| sum + kv[1]}
    end
  end

  def populate
    populate_markov_words
    populate_markov_sum
  end

  def rand_count(r)
    return r if r.kind_of? Integer
    rand(r.max-r.min)+r.min
  end

  # options:
  #     :source_material => string
  #     :source_material_file => filename
  #     :randomizer - responds to .rand(limit)
  #     :punctuation_distribution => %w{. . . . . . . . ? !} - punctiation is randomly selected from this array
  def initialize(options={})
    @init_options = options
    @randomizer = randomizer || Random.new()
    @punctuation_distribution = options[:punctuation_distribution] || %w{. . . . . . . . ? !}

    populate
  end

  def inspect
    "#<#{self.class}: #{@words.length} words, #{@markov_words.length} word-chains, #{@first_words.length} first_words>"
  end

  def next_word(word)
    return if !markov_words[word]
    sum = @markov_weighted_sum[word]
    random = rand(sum)+1
    partial_sum = 0
    markov_words[word].find do |word, count|
      partial_sum += count
      partial_sum >= random
    end.first
  end
  
  def rand(limit=nil)
    @randomizer.rand(limit)
  end

  # return a random word  
  def word
    @cached_word_keys ||= words.keys
    @cached_word_keys[rand(@cached_word_keys.length)]
  end

  # return a random first word of a sentance
  def first_word 
    @cached_first_word_keys ||= first_words.keys
    @cached_first_word_keys[rand(@cached_first_word_keys.length)]
  end

  # return a random first word of a sentance
  def markov_word 
    @cached_markov_word_keys ||= markov_words.keys
    @cached_markov_word_keys[rand(@cached_markov_word_keys.length)]
  end

  def punctuation
    @punctuation_distribution[rand(@punctuation_distribution.length)]
  end
  
  # return a random sentance
  # options:
  #   * :first_word => nil - the start word
  #   * :words => range or int - number of words in sentance
  #   * :punctuation => nil - punction to end the sentance with (nil == randomly selected)
  def sentance(options={})
    word = options[:first_word] || self.markov_word
    count = rand_count options[:words] || (3..15)
    punctuation = options[:punctuation] || self.punctuation

    capitalize(count.times.collect do 
      word.tap {word = next_word(word)}
    end.compact.join(" ") + punctuation)
  end
  
  # return a random sentance
  # options:
  #   * :first_word => nil - the start word
  #   * :words => range or int - number of words in sentance
  #   * :sentances => range or int - number of sentances in paragraph
  #   * :punctuation => nil - punction to end the sentance with (nil == randomly selected)
  def paragraph(options={})
    count = rand_count options[:sentances] || (5..15)

    count.times.collect {sentance(options)}.join(" ")
  end
end
end