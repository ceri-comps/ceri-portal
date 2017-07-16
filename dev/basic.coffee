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

  tests: portal: ->
    before (done) -> setTimeout done, 100
    it "should default to document.body", =>
      @p1.parentNode.should.equal document.body

    it "should work with selector string", =>
      @p2.parentNode.should.equal @c2

    it "should work #if", (done) =>
      @p1.parentNode.should.equal document.body
      @toggled = false
      @$nextTick =>
        should.not.exist @p1.parentNode
        @toggled = true
        @$nextTick =>
          @p1.parentNode.should.equal document.body
          done()
