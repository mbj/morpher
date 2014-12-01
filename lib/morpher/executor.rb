# encoding: utf-8

module Morpher

  # Base executor to kick off evaluators
  class Executor
    include Concord.new(:evaluator)
  end # Executor
end # Morpher
