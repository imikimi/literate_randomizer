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

> Noted from these we ascended together with my opinion we towed. Got there to home. This was more hopeless one thing only a champion and in the future. Happen to my three times backwards with proper Berserk mood Every plant even. Violently was a voice from their nature of all alone When we approached it with. Within limits to be a slight. Advantage of caves from the only have seen a disconsolate and placed. Processes of what animal with me entirely dogmatic upon the chin. Intelligence could clearly full of Maple White with skins like? Canopy of painting which furnished me no alternative and learned. Ordinary rock had. Clubs and close by its stronger and knives! Crushed and he loosened our memorable expedition as.

> Chambers in the great kindness and there came down early. Modified and I fear from where their owners and get out and the Peruvian. Congratulating each other men in the bank. Small and cold and Summerlee be prepared no such a bit. Mast-heads of Indians was the females. Swollen knee was a nightmare memory in paragraph E. Cookin'-pot so much indebted to have demonstrated this mighty thin goat-like. Terrors of course Beaumont was I could be allowed to my arms seemed. Scrub the Project Gutenberg Literary Archive Foundation are on a story. Lips but the matter of bridge was a strictly! Grew there was more for Professor who lived to look at her. Mission of the proceedings. Bunching up his native symbols a fierce red gleam of course of. Generations all of the outside the plateau on its height but I looked.

> Ringing sound of them however. Instituted very strong when Professor Summerlee. Council of it is being filled the law of Project Gutenberg-tm electronic work by? Many-colored bird which we had wandered off by this height? Overhead and close to find the bank of relief party and listened. Introduce you will only the still.

> Boughs above our knees shaking their deportment in a month could see. Gutenberg-tm License terms their base of. Dead traveler is there was held Summerlee rising mists. Expedition is indeed a little. Alone I did not succeeded. Revelation though of being.

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
