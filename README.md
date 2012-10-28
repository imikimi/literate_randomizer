# LiterateRandomizer

A random sentence and paragraph generator gem. Using Markov chains, this generates near-english prose.

## Installation

Add this line to your application's Gemfile:

    gem 'literate_randomizer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install literate_randomizer

## Basic Usage (global instance)

The simplest way to use LiterateRandomizer is the global Randommizer instance: LiterateRandomizer.global. Any method you invoke on LiterateRandomizer gets forwarded to this instance. Examples:

    require 'literate_randomizer'

    LiterateRandomizer.word
    # => "frivolous"

    LiterateRandomizer.sentence
    # => "Muscular arms round opening of sorts while Lord John Roxton."

    LiterateRandomizer.paragraph
    # => "Fulmination against the wandering that the woes of this. Particular package of the back to matchwood. File with hideous jaws of Southampton. Adventure and he. Skewered on to pledge."

    puts LiterateRandomizer.paragraphs

The last line outputs:

> Bane of him away from the bushes waiting for it all rushed me like. Settled determination that he then louder and talked of bitter disappointment and that had. Larger ones were one markedly lighter than a journey which began to them. Leave that foolish and without. Parcel of baggage gave a sight while in vain. Peculiarities are monstrous kangaroos. Volume with them.

> Communication reaches the less than harmonious. Absorb us must do not remind this scientific truth? Issued directions which contained the Chestnuts three. Ally of humor moving. Over it was a drawer he waved his beard the evening. Purged that proud delicate profile of this point I am so I could have. Throaty croaking far off those monstrous bat what would increase his eyes? Amiable but forget the results to abide by the Daily Gazette as long slope.

> Shredded into each in the pterodactyl we were engaged two or distributing a work. Refund from my pocket and rippling beard and turning into. Contact the first found at a thousand miles and tore. Uppish old types of our way which carried off the proceedings began in upon. Usual scientific mind was inclined to be described? Leafy archway began to provide. Here's something which I wondered where I thought came upon the body. Types surviving and numerous papers including checks online. Ran past ages the wood and Summerlee burst between his? Slur upon the foils and it was in a very different things before the angle. Portions of an intrusive rascals who agree to agree.

When creating a randomizer, there are a few options. The source_material should be a large selection of english text. For example, included is "The Lost World" by Aurthor Conan Doyal from Project Gutenberg.

**create** options:

    LiterateRandomizer.create(options={})
      :source_material => string OR
      :source_material_file => filename
      :randomizer => Random.new(seed=0)
      :punctuation_distribution => DEFAULT_PUNCTUATION_DISTRIBUTION - punctuation is randomly selected from this array

**paragraph** options:

    LiterateRandomizer.paragraph(options={})
      :first_word => nil - the start word
      :words => range or int - number of words in sentence
      :sentences => range or int - number of sentences in paragraph
      :punctuation => nil - punctuation to end the sentence with (nil == randomly selected from punctuation_distribution)

**paragraphs** options:

    LiterateRandomizer.paragraphs(options={})
      :first_word => nil - the first word of the paragraph
      :words => range or int - number of words in sentence
      :sentences => range or int - number of sentences in paragraph
      :punctuation => nil - punctuation to end the paragraph with (nil == randomly selected from punctuation_distribution)
      :paragraphs => range or int - number of paragraphs in paragraph
      :join => "\n\n" - join the paragraphs. if :join => false, returns an array of the paragraphs

Advanced example:

    LiterateRandomizer.paragraph :sentences => 5, :words => 3..8, :first_word => "A", :punctuation => "!!!"
    # => "A dense mob of our. Gods on that Challenger. Invariably to safety though. Weaponless but it my! Some bandy-legged lurching creature!!!"

If you just want to use a single, global instance, you can initialize and access it this way:

    # initialize on first call
    # use the same options as .create
    LiterateRandomizer.global(options={})

    # after the first call, options are ignored and the existing randomizer is returned
    LiterateRandomizer.global.sentence
    # => "Muscular arms round opening of sorts while Lord John Roxton."

    # or even simpler, all methods on LiterateRandomizer are forward to LiterateRandomizer.global:
    LiterateRandomizer.paragraph(:sentences => 3, :words => 3)
    # => "Drama which would. Wrong fashion which. Throw them there."

## Inspiration

Thanks to Tim Riley for getting me started on the right track with this <a href="http://openmonkey.com/blog/2008/10/23/using-markov-chains-to-provide-english-language-seed-data-for-your-rails-application/">blog post</a>.

## Changelog

### v0.4.0

* Random sentences now start with a word that starts a sentence in the source-material.
* Improved parsing of source-text. More work to do here, though. (For example, "Mr." is treated as a sentence end.)
* Tests are now "random-agnostic". Every change in the randomizer effects the random output. So, small changes broke all tests. No longer!
* Major code refactor: Created Randomizer, SourceParser and Util classes

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
