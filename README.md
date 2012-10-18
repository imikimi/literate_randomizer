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

> Lions and his companions it dropped his warning snort and for the. Passing then go the marking. Crush us in upon the feuds of drama of the tales which. Pipes of which embarrassed me and you in the. Studies of cattle and plunge of. Journal of his shoulder of the Trafalgar Square and the huge turtles. Grace that there existed an exclamation of other work is. Spire-like pinnacle from sight a brain for one on looking up. Work-shop and sat in the reeds of some of the half-breed endlessly repeated slowly. Parcel of good word exchanged among unknown land! Yonder where the rifles they.

> Complying with Challenger George Edward Challenger on them are. Useless gun and they trotted. Bamboos and we had some. Eccentric circle closed the great hairy gorilla-like variety to you a. Beyond a considerable doubts to realize. Patches like that ran Summerlee had. VII To-morrow I shall hold of things but there still chuckled with. Prevailing wind upon the chauffeur who! Glad to the room for. Reached you paid a most unexpected nature and too.

> Mend it will you rather than forty died away and tolerant smile. Going I left the gleam of my lad for. Machine readable form including including legal fees to the. Anchors in the wing was imperfectly heard the. Noticed something which extended to exploit for his half-closed eyes looking back to hand. Clumps with paragraph E or hypertext form of such men wiry energy. Disastrous results showed that I will need not only the copyright laws in a. Mend it would by imposing it was laid before I tramped. Outdated equipment he ever walked this agreement disclaim. Tract of the swamp. Speedily discovered the. Donors in the!

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
