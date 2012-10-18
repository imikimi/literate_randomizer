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

    require 'literate_randomizer'

    lr.word
    # => "frivolous" 
    lr.sentance
    # => "Muscular arms round opening of sorts while Lord John Roxton." 
    lr.paragraph
    # => "Tapped by his feet and the sign of the woods partly! Promoters might find such a row some rough hulking creatures we get a! Prove to think if we killed him state visit http While. Trusted ourselves and leaving the temperature ranges from the. Formally declared that if he will want to a howling the. Attentive neutrality. Helped to place where we heard the wide slow-moving clay-tinted stream and his. Itself as yet I was one circle of leathery wings as will understand." 

When creating a randomizer, there are a few options. The source_material should be a large selection of english text. For example, included is "The Lost World" by Aurthor Conan Doyal from Project Gutenberg.

    options:
      :source_material => string OR
      :source_material_file => filename
      :randomizer => Random.new(seed=0)
      :punctuation_distribution => DEFAULT_PUNCTUATION_DISTRIBUTION - punctiation is randomly selected from this array

Here are the options for the paragraph method:

    options:
      :first_word => nil - the start word
      :words => range or int - number of words in sentance
      :sentances => range or int - number of sentances in paragraph
      :punctuation => nil - punction to end the sentance with (nil == randomly selected from punctuation_distribution)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
