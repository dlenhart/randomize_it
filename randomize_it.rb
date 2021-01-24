# frozen_string_literal: true

module RandomizeIt
  # RandomizeIt - A module for generating randomized fake data
  #
  # Author  : Drew D. Lenhart
  # Desc    : A self contained module to randomize data.
  # Date    : January 2021
  # Usage   : RandomizeIt::Random.first_name  >>  "Bruce"
  #
  class Random
    class << self
      # Get constants
      def find(key)
        Random.const_get key.upcase.to_s
      end

      # Number duplicator
      def duplicate_num(count)
        num = ''
        count.times { num += rand(0..9).to_s }
        num
      end

      # Accepted method names for a standard word shuffle
      def standard_shuffle
        %w[first_name last_name middle_name suffix prefix]
      end

      # Accepted methods for random numbers by count
      def standard_numbers
        { 'country_code' => 2, 'area_code' => 3,
          'exchange_code' => 3, 'subscriber_number' => 4,
          'zip_code' => 5 }
      end

      # Dynamically create methods for standard shuffle
      RandomizeIt::Random.standard_shuffle.each do |method|
        self.class.define_method(:"#{method}") do
          find(__method__.to_s).shuffle.sample
        end
      end

      # Dynamically create methods for number variations
      RandomizeIt::Random.standard_numbers.each_pair do |method, number|
        self.class.define_method(:"#{method}") do
          duplicate_num(number)
        end
      end

      # Random phone number - set domestic = false for full U.S.
      def phone_number(domestic = false, usa = true)
        country = usa ? '1' : country_code.to_s # usa condition defaulted.

        if domestic
          "(#{area_code}) #{exchange_code}-#{subscriber_number}"
        else
          "#{country}-#{area_code}-#{exchange_code}-#{subscriber_number}"
        end
      end

      # Random last name with random characters added
      # ensures complete randomness even though it makes no sense.
      def last_name_extra_characters
        "#{last_name}#{Array.new(10) { [*'a'..'z'].sample }.join}"
      end

      # Random email address
      def email_address(characters = 13)
        carrier = find(__method__.to_s)
        mail = Array.new(characters) { [*'a'..'z'].sample }.join
        "#{mail}@#{carrier.sample}"
      end

      # Random user user_name using first and last names
      def user_name(given = '')
        if given.to_s.strip.empty?
          "#{first_name.downcase}_#{last_name.downcase}#{rand(1..99)}"
        else
          "#{given.downcase}#{rand(1..99)}"
        end
      end

      # Random password with a-z chars
      def password(characters = 10)
        (0...characters).map { rand(65..90).chr }.join
      end

      # Random street address
      def street_address
        random_street_suffix = find(__method__.to_s)
        street_number = Array.new(rand(1..5)) { rand(0..9) }.join
        "#{street_number} #{first_name} #{random_street_suffix.sample}"
      end

      alias email email_address
      alias firstname first_name
      alias middle middle_name
      alias lastname last_name
      alias street street_address
      alias phone phone_number
      alias zip zip_code
    end

    # CONSTANTS
    FIRST_NAME = %w[
      Peter Lea Ben Luke Tony Bruce Nick Drew Boba Steve Clint Loki Clark
      Bruce Barry Wally Iris Diana Lane Hal Jean Scott Jubilee John Terry
      Bob Robert Tom Drew Lucas Travis Ohm Austin Jordan Jeanette Amber Johnny
      Laura Margaret Laney Lana Mathew Tina Kyle Dan Michelle Harry Winston Egon
    ].freeze

    LAST_NAME = %w[
      Skywalker Organna Kenobi Solo Banner Parker Fury Stark Barton Romanov
      Fett Rogers Kent Wayne Kyle Allen West Damien Prince Lois Jordan Grey
      Summers Henry Roberts Thumb Terry Peterson Dern Tuner Gibson Price Miller
      Yoder Peterson Perry Pots Spengler Venkman Zeddermore Melnitz Barrett Zuul
    ].freeze

    MIDDLE_NAME = %w[
      Todd Marie Jonathan Sarah Sally Meridia Timothy Terry Tommy Doug Rod Rodderick
      Derek Dana Dan Diane Donald Elizabeth Katherine Kat Katy Anne Ann Lynn James
      William Thomas Allen
    ].freeze

    SUFFIX = ['Jr', 'Sr', 'I', 'II', 'MD', 'DDS', 'PhD'].freeze

    PREFIX = ['Mr.', 'Mrs.', 'Ms.', 'Miss', 'Dr'].freeze

    EMAIL_ADDRESS = ['gmail.com', 'hotmail.com', 'yahoo.com', 'comcast.com',
                     'comcast.net', 'msn.com', 'frontier.com', 'att.com'].freeze

    STREET_ADDRESS = %w[
      Alley Avenue Branch Bridge Brook Brooks Burg Burgs Bypass Camp Canyon
      Cape Causeway Center Centers Circle Circles Cliff Cliffs Club Common Corner
      Corners Course Court Courts Cove Coves Creek Crescent Crest Crossing Crossroad
      Curve Dale Dam Divide Drive Drive Drives Estate Estates
    ].freeze

    private_constant :LAST_NAME
    private_constant :FIRST_NAME
    private_constant :SUFFIX
    private_constant :PREFIX
    private_constant :EMAIL_ADDRESS
    private_constant :STREET_ADDRESS
  end
end
