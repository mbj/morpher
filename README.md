ducktrap
========

[![Build Status](https://secure.travis-ci.org/mbj/ducktrap.png?branch=master)](http://travis-ci.org/mbj/ducktrap)
[![Dependency Status](https://gemnasium.com/mbj/ducktrap.png)](https://gemnasium.com/mbj/ducktrap)
[![Code Climate](https://codeclimate.com/github/mbj/ducktrap.png)](https://codeclimate.com/github/mbj/ducktrap)

Ducktrap is a spike for a data transformation algebra. The main idea is to define the transformations with
composable blocks that allow to generate an inverse transformation.

It can be used at various places:

* Domain to JSON and vice versa, for building rest style APIS
* Domain to document db and vice versa, for buidling mappers
* Form processing
* ...

Installation
------------

There is no gem release.

Examples
--------

For slightly more details, have a look at this [gist](https://gist.github.com/mbj/6938357) for now.

A simple real world scenario would probably look something like this:

```ruby
require 'anima'
require 'ducktrap'

class Address
  include Anima.new(:id, :city, :zip)

  TRAP = Ducktrap.build do
    primitive(Hash)
    hash_transform do
      fetch_key(:id) do
        primitive(Integer)
        dump_key(:id)
      end

      fetch_key(:city) do
        primitive(String)
        dump_key(:city)
      end

      fetch_key(:zip) do
        primitive(Integer)
        dump_key(:zip)
      end
    end
    anima_load(Address)
  end
end

class Task
  include Anima.new(:id, :name)

  TRAP = Ducktrap.build do
    primitive(Hash)
    hash_transform do
      fetch_key(:id) do
        primitive(Integer)
        dump_key(:id)
      end

      fetch_key(:name) do
        primitive(String)
        dump_key(:name)
      end
    end
    anima_load(Task)
  end
end

class Person
  include Anima.new(:id, :name, :address, :tasks)

  DEFAULTS = {address: nil, tasks: []}

  TRAP = Ducktrap.build do
    primitive(Hash)
    hash_transform do
      fetch_key(:id) do
        primitive(Integer)
        dump_key(:id)
      end

      fetch_key(:name) do
        primitive(String)
        dump_key(:name)
      end

      fetch_key(:address) do
        add(Address::TRAP)
        dump_key(:address)
      end

      fetch_key(:tasks) do
        map { add(Task::TRAP) }
        dump_key(:tasks)
      end
    end
    anima_load(Person)
  end

  def initialize(attributes)
    super(DEFAULTS.merge(attributes))
  end
end


t_hash = {id: 1, name: 'DOIT'}
a_hash = {id: 1, city: 'Linz', zip: 4040}
p_hash = {id: 1, name: 'John', address: a_hash, tasks: [t_hash]}

evaluator = Person::TRAP.call(p_hash)

if evaluator.success?
  puts evaluator.output.inspect
  # => #<Person id=1 name="John" address=#<Address id=1 city="Linz" zip=4040> tasks=[#<Task id=1 name="DOIT">]>
else
  puts evaluator.pretty_dump
end
```

Credits
-------

* [mbj](https://github.com/mbj)

Contributing
------------

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with Rakefile or version
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

License
-------

See LICENSE file.
