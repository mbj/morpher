# frozen_string_literal: true

require 'abstract_type'
require 'adamantium'
require 'anima'
require 'concord'
require 'mprelude'

module Morpher
  Either = MPrelude::Either

  EMPTY_HASH = {}.freeze
end

require 'morpher/newtype'
require 'morpher/record'
require 'morpher/transform'
