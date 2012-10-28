require File.join(File.dirname(__FILE__),"..","lib","literate_randomizer")

describe LiterateRandomizer do

  WORD="[a-zA-Z]+([-'][a-zA-Z]+)*"
  CWORD="[A-Z][a-zA-Z]*([-'][a-zA-Z]+)*"
  PUNCTUATION="[!.?]"
  SENTENCE_TAIL = "( #{WORD})*#{PUNCTUATION}"
  SENTENCE="#{CWORD}#{SENTENCE_TAIL}"
  SENTENCES="#{SENTENCE}( #{SENTENCE})+"

  def new_lr(options={})
    $lr ||= LiterateRandomizer.create options
    $lr.randomizer = Random.new(1)
    $lr
  end

  before(:each) do
    LiterateRandomizer.global.randomizer = Random.new(1)
  end

  it "should be possible to create a randomizer" do
    lr = new_lr
    lr.should_not == nil
  end

  it "words.length should be the number of words in the file" do
    new_lr.model.words.length.should == 9117
  end

  it "first_words.length should be the number words starting sentences in the file" do
    new_lr.model.first_words.length.should == 585
  end

  it "word should return a random word" do
    new_lr.word.should match /[a-z]+/
  end

  it "sentence should return a random sentence" do
    new_lr.sentence.should match /^#{SENTENCE}$/
  end

  it "if we keep resetting the randomizer we should keep getting the same sentence" do
    s = new_lr.sentence
    10.times do
      new_lr.sentence.should == s
    end
  end

  it "sentence length should work" do
    new_lr.sentence(:words => 1).split(' ').length.should == 1
    new_lr.sentence(:words => 2).split(' ').length.should == 2
    new_lr.sentence(:words => 3).split(' ').length.should == 3
    new_lr.sentence(:words => 9).split(' ').length.should == 9
    a = new_lr.sentence(:words => 2..7).split(' ')
    a.length.should >= 2
    a.length.should <= 7
  end

  it "successive calls should vary" do
    lr = new_lr
    a,b,c = lr.sentence,lr.sentence,lr.sentence
    a.should_not == b
    b.should_not == c
    c.should_not == a
  end

  it "paragraph should work" do
    new_lr.paragraph.should match /([A-Z][a-zA-Z ]+[.!?])+/
  end

  it "paragraph parameters should work" do
    new_lr.paragraph(:sentences => 5, :words=>3).should match /^(#{CWORD} #{WORD} #{WORD}[.!?] ?){5,5}$/
    new_lr.paragraph(:sentences => 2..4, :words=>3).should match /(#{CWORD} #{WORD} #{WORD}[.!?] ?){2,4}/
  end

  it "first_word should work" do
    new_lr.paragraph(:first_word => "A",:sentences => 5, :words=>3).should match /^A#{SENTENCE_TAIL} #{SENTENCES}$/
  end

  it "punctuation should work" do
    new_lr.paragraph(:punctuation => "!!!",:sentences => 5, :words=>3).should match /^(#{CWORD} #{WORD} #{WORD}[.!?] ?){4,4}#{CWORD} #{WORD} #{WORD}!!!$/
  end

  it "global_randomizer_should work" do
    LiterateRandomizer.global.class.should == LiterateRandomizer::Randomizer
  end

  it "global_randomizer_should forwarding should work" do
    LiterateRandomizer.respond_to?(:paragraph).should == true
    LiterateRandomizer.respond_to?(:fonsfoaihdsfa).should == false
    LiterateRandomizer.word.should match /^#{WORD}$/
    LiterateRandomizer.sentence.should match /^#{SENTENCE}$/
    LiterateRandomizer.paragraph.should match /^#{SENTENCES}$/
  end

  it "join param should work" do
    LiterateRandomizer.paragraphs(:paragraphs => 2, :words =>2, :sentences => 2, :join=>"--").should match /^#{SENTENCES}--#{SENTENCES}$/
  end

  it "global_randomizer_should forwarding should work" do
    LiterateRandomizer.paragraphs(:paragraphs => 2, :words =>2, :sentences => 2).should match /^#{SENTENCE} #{SENTENCE}\n\n#{SENTENCE} #{SENTENCE}$/
    a = LiterateRandomizer.paragraphs(:paragraphs => 2, :words =>2, :sentences => 2, :join=>false)
    a.length.should == 2
    a.each {|b|b.should match /^#{SENTENCES}$/}
  end
end
