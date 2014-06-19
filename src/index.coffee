getto = require 'getto'

extend = (obj, extensions) ->
  (obj[key] = value) for key, value of extensions

module.exports = modelMixin = ({statics, methods}={}) ->
  statics ?= {}
  methods ?= {}

  mixin = (target) ->
    return unless target?
    if target.static? and target.method? # It's a mongoose schema
      target.static statics
      target.method methods
    else if target.constructor is Object # It's a native Object instance
      extend(getto(target), methods)
    else
      extend(target, statics)
      extend(target::, methods)

    target

  # sometimes we need access to the methods from the mixin
  extend(mixin, {statics, methods})
  mixin

