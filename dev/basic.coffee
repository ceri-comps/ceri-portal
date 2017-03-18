window.customElements.define "ce-portal", require "../src/portal.coffee"
createView = require "ceri-dev-server/lib/createView"
module.exports = createView
  mixins: [
    require "ce/#if"
  ]
  structure: template 1, """
    <p>within container</p>
    <a href="https://github.com/ceri-comps/ceri-portal/blob/master/dev/basic.coffee">source</a>
    <br/><br/>
    <button @click.toggle="toggled">toggle portal to body</button>
    <ce-portal #ref="portal1" #if="toggled">
      <p #ref="p1" >teleported to body</p>
    </ce-portal>
    <ce-portal #ref="portal2" target=".container2">
      <p #ref="p2">teleported to container2 by selector</p>
    </ce-portal>
    
    <div #ref="c2" class="container2" style="background-color: lightgrey;margin-top: 20px;">
      <p>within container2</p>
    </div>
  """
  data: ->
    toggled: true


  tests: (el) ->
    describe "portal", ->
      after ->
        el.remove()
      it "should default to document.body", ->
        el.p1.parentNode.should.equal document.body

      it "should work with selector string", ->
        el.p2.parentNode.should.equal el.c2

      it "should work #if", (done) ->
        el.p1.parentNode.should.equal document.body
        el.toggled = false
        el.$nextTick ->
          should.not.exist el.p1.parentNode
          el.toggled = true
          el.$nextTick ->
            el.p1.parentNode.should.equal document.body
            done()
