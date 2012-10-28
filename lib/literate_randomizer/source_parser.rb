module LiterateRandomizer

# Parse the source material and provide "each_sentence" - an easy way to walk the source material.
class SourceParser
  private
  attr_reader :init_options

  public
  # Options:
  #
  # * :source_material => string OR
  # * :source_material_file => filename
  def initialize(options)
    @init_options = options
  end

  # read the default source material included with the gem
  def default_source_material
    File.expand_path File.join(File.dirname(__FILE__),"..","..","data","the_lost_world_by_arthur_conan_doyle.txt")
  end

  # Options:
  #
  #     :source_material => string
  #     :source_material_file => filename
  def source_material(options=init_options)
    options[:source_material] || File.read(options[:source_material_file] || default_source_material)
  end

  # Read the source material and split it into sentences
  # NOTE: this re-reads the source material each time. Usually this only needs to happen once and it would waste memory to keep it around.
  def source_sentences
    source_material.split(/([.?!"]($|\s)|\n\s*\n)+/)
  end

  # remove any non-alpha characters from word
  def scrub_word(word)
    word &&= word[/[A-Za-z][A-Za-z'-]*/]
    word &&= word[/[A-Za-z'-]*[A-Za-z]/]
    (word && word.strip) || ""
  end

  # clean up all words in  a string, returning an array of clean words
  def scrub_sentence(sentence)
    sentence.split(/([\s]|--)+/).collect {|a| scrub_word(a)}.select {|a| a.length>0}
  end

  # Yields to a block each sentence as an array of words
  def each_sentence
    source_sentences.each do |sentence|
      yield scrub_sentence sentence
    end
  end
end
end
