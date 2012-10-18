require File.join(File.dirname(__FILE__),"..","lib","literate_randomizer")

describe LiterateRandomizer do

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
    new_lr.words.length.should == 9143
  end

  it "first_words.length should be the number words starting sentances in the file" do
    new_lr.first_words.length.should == 754
  end

  it "source_sentances.length should be the number of sentances in the file" do
    new_lr.source_sentances.length.should == 10699
    new_lr.source_sentances.length.should > new_lr.first_word.length
  end

  it "word should return a random word" do
    new_lr.word.should == "own"
  end

  it "sentance should return a random sentance" do
    new_lr.sentance.should == "Bad form of my own chances are a riding-whip."
  end

  it "sentance length should work" do
    new_lr.sentance(:words => 1).should == "Bad."
    new_lr.sentance(:words => 3).should == "Bad money if."
    new_lr.sentance(:words => 5).should == "Bad money if ever come."
    new_lr.sentance(:words => 7).should == "Bad money if ever come outwards at."
    new_lr.sentance(:words => 9).should == "Bad money if ever come outwards at the side."
    new_lr.sentance(:words => 2..7).should == "Bad job for a final credit."
  end

  it "successive calls should vary" do
    lr = new_lr
    lr.sentance.should == "Bad form of my own chances are a riding-whip."
    lr.sentance.should == "Hit you chaps think of battle Our young fellah when in Streatham."
    lr.sentance.should == "Upward curves which should be through the whole tribe."
  end

  it "paragraph should work" do
    new_lr.paragraph.should == "Bad form of my own chances are a riding-whip. Hit you chaps think of battle Our young fellah when in Streatham. Upward curves which should be through the whole tribe. Mend it at Edinburgh rose and it in diameter. Placed behind him. Rubbing his elephant-gun and sloth which way up to Project Gutenberg is going. Columns until he came at a last. Elusive enemies while beneath the main river up in it because on a boiling. Burying its coloring that skull and that there was able. Eventful moment of my clothes were to visit."
  end

  it "first_word should work" do
    new_lr.paragraph(:sentances => 5, :words=>3).should == "Bad money if. Discreetly vague way. Melee in that. Hopin that dreadful. Executive and hold."
    new_lr.paragraph(:sentances => 2..4, :words=>3).should == "Bad money if. Discreetly vague way. Melee in that."
  end

  it "first_word should work" do
    new_lr.paragraph(:first_word => "A",:sentances => 5, :words=>3).should == "A roaring rumbling. Instanced a journalist. Eight after to-morrow. Hopin that dreadful. Executive and hold."
  end

  it "punctuation should work" do
    new_lr.paragraph(:punctuation => "!!!",:sentances => 5, :words=>3).should == "Bad money if. Discreetly vague way. Melee in that. Hopin that dreadful. Executive and hold!!!"
  end

  it "global_randomizer_should work" do
    LiterateRandomizer.global.class.should == LiterateRandomizer::MarkovChain
  end

  it "global_randomizer_should forwarding should work" do
    LiterateRandomizer.respond_to?(:paragraph).should == true
    LiterateRandomizer.respond_to?(:fonsfoaihdsfa).should == false
    LiterateRandomizer.word.should == "own"
    LiterateRandomizer.sentance.should == "Beak filled in the side of Vertebrate Evolution and up into private."
    LiterateRandomizer.paragraph.should == "GUTENBERG-tm concept of their rat-trap grip upon Challenger of the carrying of selfishness! Telling you with great enterprise upon their own eventual goal and it in a liar. The complete your consent. Reporters down at a tangle of the huge flippers behind us in writing. Chandeliers in those huge wings of this agreement and Ipetu. Taken the gray eyes were general laws of what. Variety of photographs said for the words?"
  end

  it "global_randomizer_should forwarding should work" do
    LiterateRandomizer.paragraphs(:words =>2, :sentances => 2).should == "Bad money. Instanced a.\n\nFLAIL OF. Melee in.\n\nHit you. Executive and.\n\nHopes and. Puffing red-faced."
    LiterateRandomizer.paragraphs(:words =>2, :sentances => 2, :join=>"--").should == "Pick holes. Telling you.--Mend it. Considerate of!--Albany and! Fame or?--The weak. Prime mover."
    LiterateRandomizer.paragraphs(:words =>2, :sentances => 2, :join=>false).should == ["Reporters down. Again the.", "Their position. Dressing down.", "Chandeliers in. Although every."]
  end
end
