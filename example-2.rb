require 'morpher'

extend Morpher::NodeHelpers

class Input
  include Anima.new(:foo)
end # Input

# Input.new(:foo => 'bar')

node =
  s(:block,
    s(:guard, s(:primitive, Hash)),
    s(:hash_transform,
      s(:symbolize_key, :foo,
        s(:guard,
          s(:or,
            s(:primitive, String),
            s(:primitive, NilClass)
          )
        )
      )
    ),
    s(:anima_load, Input)
  )

EVALUATOR = Morpher.compile(node)
