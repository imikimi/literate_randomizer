# LiterateRandomizer

A random sentence and paragraph generator gem. Using Markov chains, this generates near-english prose.

## Installation

Add this line to your application's Gemfile:

    gem 'literate_randomizer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install literate_randomizer

## Usage

Example:

    require 'literate_randomizer'

    lr = LiterateRandomizer.create

    lr.word
    # => "frivolous" 

    lr.sentance
    # => "Muscular arms round opening of sorts while Lord John Roxton." 

    lr.paragraph
    # => "Tapped by his feet and the sign of the woods partly! Promoters might find such a row some rough hulking creatures we get a! Prove to think if we killed him state visit http While. Trusted ourselves and leaving the temperature ranges from the. Formally declared that if he will want to a howling the. Attentive neutrality. Helped to place where we heard the wide slow-moving clay-tinted stream and his. Itself as yet I was one circle of leathery wings as will understand." 

    puts lr.paragraphs

The last line outputs:

> Tells his chair. Town was a sign of them and pressed a minute than. Knows what it he said he is a martial Girardet and yet so. Stinking beasts during our descent. Business afterwards that to take back to the table which had. Hunt down quick upon the same broad squat head bowed until they. Handling of the forest keeping to a means sonny? Literary Archive Foundation as the same. Swears he would put out of the Amazon made. Spink's and the moment for canoes from head in each other. Sluggish viscous life that I entered shook hands.

> Can throw myself this agreement the house. Searcher for your representatives and unscrupulous at sunset the audience rising and Weissmann. Freely and come up at the face topped the Scotch. Jolly Good heavens. Silky voice of our reasons for an. Deepest circle of these creatures which fascinated to them in an instant later. Assurance of the last month or held here. Embarrassing it was as I shall descend by not. Disappeared from Fort Challenger could be now entirely fresh. There's been written explanation of the natives who may! They were to pieces was gazing curiously at first conquerors of? Dante's hell. Hall at the relations of list of insects a score. Shaky old man at the blood-beslobbered face projecting with it would not a sportsman.

> Property infringement a quick. Stood still in which has. Continually steeper until with. As an open confession. Write and they will in those. Cruel head in gregarious fashion which grew to adopt them having another. Supercilious eyes as they. SEND DONATIONS or entity providing it came back with fear or? Years ago I reach their! Roaring which was beside the bottom of this time. Surround us at. Sailing boats may safely taunted.

> Work had sunk to ask you mean us another look at random all. Laid upon his knife however enormous? Fallen greatness and stuffing some narrow and a long with this the Indians. Speeding upon my young friend has been formed. Work or with the crushing blow fell in the Brazilian forest! Stuck upon the undeveloped savages. What it was a great as I have recently. Resist unwelcome pressure of every womanly quality might. Zoologist when I was over.

When creating a randomizer, there are a few options. The source_material should be a large selection of english text. For example, included is "The Lost World" by Aurthor Conan Doyal from Project Gutenberg.

**create** options:

    LiterateRandomizer.create(options={})
      :source_material => string OR
      :source_material_file => filename
      :randomizer => Random.new(seed=0)
      :punctuation_distribution => DEFAULT_PUNCTUATION_DISTRIBUTION - punctiation is randomly selected from this array

**paragraph** options:

    LiterateRandomizer.paragraph(options={})
      :first_word => nil - the start word
      :words => range or int - number of words in sentance
      :sentances => range or int - number of sentances in paragraph
      :punctuation => nil - punction to end the sentance with (nil == randomly selected from punctuation_distribution)

**paragraphs** options:

    LiterateRandomizer.paragraphs(options={})
      :first_word => nil - the first word of the paragraph
      :words => range or int - number of words in sentance
      :sentances => range or int - number of sentances in paragraph
      :punctuation => nil - punction to end the paragraph with (nil == randomly selected from punctuation_distribution)
      :paragraphs => range or int - number of paragraphs in paragraph
      :join => "\n\n" - join the paragraphs. if :join => false, returns an array of the paragraphs

Advanced example:

    lr.paragraph :sentances => 5, :words => 3..8, :first_word => "A", :punctuation => "!!!"
    # => "A dense mob of our. Gods on that Challenger. Invariably to safety though. Weaponless but it my! Some bandy-legged lurching creature!!!"       

If you just want to use a single, global instance, you can initialize and access it this way:

    # initialize on first call
    # use the same options as .create
    LiterateRandomizer.global(options={})

    # after the first call, options are ignored and the existing randomizer is returned
    LiterateRandomizer.global.sentance
    # => "Muscular arms round opening of sorts while Lord John Roxton." 

    # or even simpler, all methods on LiterateRandomizer are forward to LiterateRandomizer.global:
    LiterateRandomizer.paragraph(:sentances => 3, :words => 3)
    # => "Drama which would. Wrong fashion which. Throw them there."

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
