expect = require('chai').expect
Backbone = require 'backbone'
mongoose = require 'mongoose'

modelMixin = require '..'

myMixin = modelMixin
  methods:
    uppercaseName: ->
      @get('name').toUpperCase()

  statics:
    version: ->
      '1.0.0'


describe 'modelMixin', ->
  model = null
  describe 'mixing in into Object', ->
    beforeEach ->
      model = { name: 'Noah' }
      myMixin(model)

    it 'has instance methods', ->
      expect(model.uppercaseName()).to.equal 'NOAH'

  describe 'mixing in to Backbone model', ->
    class MyBackboneModel extends Backbone.Model
    myMixin(MyBackboneModel)

    beforeEach ->
      model = new MyBackboneModel name: 'Noah'

    it 'has instance methods', ->
      expect(model.uppercaseName()).to.equal 'NOAH'

    it 'has static methods', ->
      expect(MyBackboneModel.version()).to.equal '1.0.0'

    it 'exposes static and instance methods on mixin', ->
      expect(myMixin.statics.version).to.equal MyBackboneModel.version
      expect(myMixin.methods.uppercaseName).to.equal model.uppercaseName

  describe 'mixing in to Mongoose model', ->
    schema = new mongoose.Schema
      name: String
    myMixin(schema)
    MyMongooseModel = mongoose.model('MyMongooseModel', schema)

    beforeEach ->
      model = new MyMongooseModel name: 'Noah'

    it 'has instance methods', ->
      expect(model.uppercaseName()).to.equal 'NOAH'

    it 'has static methods', ->
      expect(MyMongooseModel.version()).to.equal '1.0.0'

    it 'exposes static and instance methods on mixin', ->
      expect(myMixin.statics.version).to.equal MyMongooseModel.version
      expect(myMixin.methods.uppercaseName).to.equal model.uppercaseName