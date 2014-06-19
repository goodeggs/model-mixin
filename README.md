# model-mixin
[![NPM version](https://badge.fury.io/js/model-mixin.png)](http://badge.fury.io/js/model-mixin)

[![Build Status](https://travis-ci.org/goodeggs/model-mixin.png)](https://travis-ci.org/goodeggs/model-mixin)

## About

At Good Eggs we are on a quest for a ubiquitous domain model implementation that works across frameworks in both the browser and in Node.js.
When you have an instance of a domain model in our applications, we want it to have the same interface and behavior, regardless
of where it is running.

In this quest we've been using a strategy in our apps at Good Eggs that achieves a similar end with a different strategy.
We write mixins that add behavior to models from different frameworks. So if you have reference to a User model in
Mongoose or Backbone, it has the same interface backed by the same code. It's not the final answer but yields a ton
of immediate benefit in minimizing code duplication and sharing behavior across browser and server.

## Usage

### Write a mixin

```
var modelMixin = require('model-mixin');

var UserMixin = modelMixin({
  methods: {
    uppercaseName: function() {
      return this.get('name').toUpperCase();
    }
   },

  statics: {
    version: function() {
      return '1.0.0';
    }
  }
});

module.exports = UserMixin;
```

### Mix in to Backbone model

```
var User = Backbone.Model.extend({});
UserMixin(User);

var user = new User({name: 'Noah'});
console.log user.uppercaseName(); // NOAH
console.log(User.version()); // 1.0.0
```

### Mix in to Mongoose model

```
var mongoose = require('mongoose');
var UserMixin = require('./user_mixin');

var schema = new mongoose.Schema({
  name: String
});
UserMixin(schema);
var User = mongoose.model('User', schema);

var user = new User({name: 'Noah'});
console.log(user.uppercaseName()); // NOAH
console.log(User.version()); // 1.0.0
```

### Mix in to JavaScript object
```
var UserMixin = require('./user_mixin');

var user = {name: 'Noah'};
UserMixin(user);

console.log(user.uppercaseName()); // NOAH
```

## Code of Conduct

[Code of Conduct](https://github.com/goodeggs/model-mixin/blob/master/CODE_OF_CONDUCT.md)
for contributing to or participating in this project.

## License

[MIT](https://github.com/goodeggs/model-mixin/blob/master/LICENSE.md)
