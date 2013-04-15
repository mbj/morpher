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

Sorry, API is stupid, so no examples for now. See specs.

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
