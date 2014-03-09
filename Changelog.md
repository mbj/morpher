[Compare v0.0.1..v0.1.0](https://github.com/mbj/morpher/compare/v0.0.1...v0.1.0)

# v0.2.0 2014-03-09

Breaking-Changes:

* Require {load,dump}_attributes_hash param to be an instance of Transformer::Domain::param

# v0.1.0 2014-03-08

Breaking-Changes:

* Renamed `Morpher.evaluator(node)` to `Morpher.compile(node)`
* Rename node: `symbolize_key` to `key_symbolize`
* Rename node: `anima_load` to `load_attributes_hash`
* Rename node: `anima_dump` to `dump_attributes_hash`
* The ability to rescue/report anima specific exceptions has been dropped

Changes:

* Add {dump,load}_{attribute_accessors,instance_variables} as additional strategies to
  transform from / to domain objects.

# v0.0.1 2014-03-02

First public release.
