# MrProper

MrProper is a Test::Unit-based library to do Property Based Testing a la [Haskell](http://haskell.org/haskellwiki/Haskell)'s [QuickCheck](http://hackage.haskell.org/package/QuickCheck).

Property Based Testing is an alternative approach to unit testing for testing functional style functions/methods. Instead of using examples and testing the return value of your function for each example, you:

1. Define the kind of data your function/method is supposed to accept
2. Define predicates (properties) your function/method is supposed to comply with

Then MrProper uses that info to randomly check lots of test cases so that you can find extra edge cases you might have forgotten in your unit tests or implementation.

In order to do so, MrProper provides a very simple DSL, with just three methods, `properties`, `data` and `property`. For example, we could describe a `double` function in terms of properties:

    require 'mrproper'
    
    properties 'double' do
      data Integer
      data Float
      
      property 'is the same as adding twice' do |data|
        assert_equal data + data, double(data)
      end
    end

## Running the properties

After implementing `double` (we'll leave that as an exercise `;)`), we run the properties as a regular test file:

    $ testrb double_properties.rb
    Run options: 

    # Running tests:

    .

    Finished tests in 0.001625s, 615.3846 tests/s, 123076.9231 assertions/s.

    1 tests, 200 assertions, 0 failures, 0 errors, 0 skips
    
Only one test runs, but notice the insane number of assertions: a lot of random `Integer` and `Float` values generated for you.

If we happen to have a buggy `double` implementation which fails for numbers greater than 20 (we're crappy developers, thats why we want tests!), MrProper will tell you the first case it finds that proves the property false:

    def double(i)
      return -666 if i > 20
      i * 2
    end

And run the properties again:

    $ testrb double_properties.rb
    Run options: 

    # Running tests:

    F

    Finished tests in 0.030735s, 32.5362 tests/s, 97.6086 assertions/s.

      1) Failure:
    test_property: "is the same as adding twice"
    Property "is the same as adding twice" is falsable for data 39
    Expected: 78
      Actual: -666

    1 tests, 3 assertions, 1 failures, 0 errors, 0 skips
    
## Data generation DSL

In addition to plain class names, we can feed `data` with more or less complex expressions to define data structures:

    data [String]               # generates arrays of strings such as
                                # ["QC", "QyNYF", "ZRHehcux", "HPos"]
                                # ["arnyaZWp", "U"] (or [])
    data [Integer, String]      # generates arrays of one integer and
                                # one string such as [-89, "cDoZZRzGco"]
                                # or [-44, "eB"]
    data [[Float]]              # generates arrays of arrays of floats
                                # such as [[0.12, 3.41], [-2.31]]
    data({Symbol => String})    # generates hashes whose keys are symbols
                                # and whose values are strings such as
                                # {:tR=>"m", :aSKnsndwWK=>"QUrGwAAh"}
                                # (in the hashes example, we need to use
                                # parenthesis because otherwise the Ruby
                                # parser thinks we're defining a block `;)`)
    data({String => [Integer]}) # generates hashes whose keys are strings
                                # and whose values are arrays of integers

In case this is not enough, you can just use a block and do whatever you want to generate the data:

    data do
      rand > 0.5 ? Wadus.new(rand(9)) : FooBar.new(rand(9))
    end

## License

Released under the [MIT license](http://github.com/porras/property/blob/master/LICENSE)

## Credits

Created during [railscamp-es](https://rails-camp-es.jottit.com/) '2011 by Sergio Gil ([@porras](http://github.com/porras)) and Mari Carmen Gutiérrez ([@valakirka](http://github.com/valakirka)), with ideas from Luismi Cavallé ([@cavalle](http://github.com/cavalle)) and feedback from many other atendees. Thank you everyone!

