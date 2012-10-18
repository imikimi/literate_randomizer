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

> Turtles strange land depended upon a short briar between my lecture upon his surroundings. Hopes and distributed in an hour or for it was fairly! Kangaroo springing in earnest desire for the aurora borealis! Spikes and dyin as Manatee upon his. Occasional brooks with all this enterprise in the famous! Bell and possibly. Excellent condition of a dangerous I will send him and me but they would. Depends upon closer study Mr. Cousin in a microcosm possessed at!

> Length of his sling his coverlet and the less than a deal too late. Spent my last week the old chief. Drove me a mile long curving wisp over to be? Don't tell also stiffened hands were fortunately I can. Parrakeets broke out what do you have undergone? Adjust our hands in my own way but absolutely certain? Lurked among the name in shooting that with conviction.

> Criticism and corresponding point why I! Devote your eyes or the hunter who had some time! Speed that the human nature of this time been sewn up on more. Skewered on the pit and singin in the drawing. Plunged in half-an-hour in http Section H British and a great liberties. Outlined against it remained in that the essence of the process. Exploit two small ribbed like to be where we held in St. Flashing eyes open space. Nerve in this confined space it in the rains might blunder in our expedition.

> Answer for an instant! Chase and they all stood by the Accala Indians made up. Couple of this country and don't know no room which he walked. Rate than half-an-hour in general form including legal fees that it was proud. Affluent of the travelers the Seven! Evil eyes staring maid and that I. Stylographic pencil but never could have come down! Vast assembly and that the exclusion or the foot. Mission of springs of scraps of a Perfectly Impossible Person. Saw white-bearded professors to have found that anyhow. Veranda was common?

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
