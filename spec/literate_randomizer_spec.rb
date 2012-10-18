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
    new_lr.sentance.should == "Bad form of my own chances are a riding-whip!"
  end

  it "sentance length should work" do
    new_lr.sentance(:words => 1).should == "Bad?"
    new_lr.sentance(:words => 3).should == "Bad job for?"
    new_lr.sentance(:words => 5).should == "Bad job for a final?"
    new_lr.sentance(:words => 7).should == "Bad job for a final credit of?"
    new_lr.sentance(:words => 9).should == "Bad job for a final credit of the side?"
    new_lr.sentance(:words => 2..7).should == "Bad job for a final credit?"
  end

  it "successive calls should vary" do
    lr = new_lr
    lr.sentance.should == "Bad form of my own chances are a riding-whip!"
    lr.sentance.should == "Hit you that book down below as his tattered sketch-book which held."
    lr.sentance.should == "Seated upon their journey up my sleeve and incalculable people start to-morrow!"
  end

  it "paragraph should work" do
    lr = new_lr
    lr.paragraph.should == "Bad form of my own chances are a riding-whip! Hit you that book down below as his tattered sketch-book which held. Seated upon their journey up my sleeve and incalculable people start to-morrow! Telling you propose to this half-educated age of the bushes at last supreme! Placed over us. Rubbing his strong sunlight struck me and Fate with the effect of. Columns until he came at a last. Elusive enemies while beneath the main river up in it because on a boiling. Burying its doe and knees and round his arms. Scraps of what came a Project Gutenberg-tm and the secret haunts."
  end

  it "first_word should work" do
    new_lr.paragraph(:sentances => 5, :words=>3).should == "Bad job for? Discreetly vague way. Melee in the. Gleam of a. Puffing red-faced irascible."
    new_lr.paragraph(:sentances => 2..4, :words=>3).should == "Bad job for? Discreetly vague way. Melee in the."
  end

  it "first_word should work" do
    new_lr.paragraph(:first_word => "A",:sentances => 5, :words=>3).should == "A roaring rumbling. Instanced a most. Melee in the. Gleam of a. Puffing red-faced irascible."
  end

  it "punctuation should work" do
    new_lr.paragraph(:punctuation => "!!!",:sentances => 5, :words=>3).should == "Bad job for? Discreetly vague way. Melee in the. Gleam of a. Puffing as a!!!"
  end

  it "global_randomizer_should work" do
    LiterateRandomizer.global.class.should == LiterateRandomizer::MarkovChain
  end

  it "global_randomizer_should forwarding should work" do
    LiterateRandomizer.respond_to?(:paragraph).should == true
    LiterateRandomizer.respond_to?(:fonsfoaihdsfa).should == false
    LiterateRandomizer.word.should == "own"
    LiterateRandomizer.sentance.should == "Beak filled in the side of Vertebrate Evolution and up into private."
    LiterateRandomizer.paragraph.should == "GUTENBERG-tm concept of their rat-trap grip upon Challenger of the carrying of. Precipices of me. Telling you propose to this half-educated age of the bushes at last supreme! Placed over us. Rubbing his strong sunlight struck me and Fate with the effect of. Columns until he came at a last. Elusive enemies while beneath the main river up in it because on a boiling."
  end

  it "global_randomizer_should forwarding should work" do
    LiterateRandomizer.paragraphs(:words =>2, :sentances => 2).should == "Bad job? Instanced a.\n\nEight after. Hopin that.\n\nGleam of. Puffing red-faced.\n\nDiscover a! Mass of."
    LiterateRandomizer.paragraphs(:words =>2, :sentances => 2, :join=>"--").should == "Telling you! Mend it.--Considerate of. Albany and?--Fame or. The weak."
    LiterateRandomizer.paragraphs(:words =>2, :sentances => 2, :join=>false).should == ["Prime mover. Historical architecture!", "Reporters down! Again the.", "Their position. Dressing down.", "Gigantic old. Huge steamers."]
  end
end
