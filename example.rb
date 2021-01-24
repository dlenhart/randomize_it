# frozen_string_literal: true

require_relative 'randomize_it'

# EXAMPLE USAGE - Drew D. Lenhart - Jan 2021
#
first     = RandomizeIt::Random.first_name
last      = RandomizeIt::Random.last_name
middle    = RandomizeIt::Random.middle_name
suffix    = RandomizeIt::Random.suffix
prefix    = RandomizeIt::Random.prefix
phone     = RandomizeIt::Random.phone
user_name = RandomizeIt::Random.user_name("#{last}_#{first}")
password  = RandomizeIt::Random.password
email     = RandomizeIt::Random.email
street    = RandomizeIt::Random.street
zip       = RandomizeIt::Random.zip

# STORY TIME
#
story     = "\n1. INSERT IDENTIFICATION CARD\n"\
            "2. PLEASE READ THE FOLLOWING: \n"\
            "\tHi. "\
            "My name is #{prefix} #{first} #{middle} #{last} #{suffix}.\n"\
            "\tI live at #{street} and my zipcode is #{zip}.\n"\
            "\tI can be reached via phone at #{phone}.\n"\
            "\tMy email address is #{email}.\n"\
            "\tMy login name is #{user_name}.\n"\
            "\tAnd my passcode is #{password}.\n\n"\
            "\tVerify me.\n\n"\

puts story.upcase
