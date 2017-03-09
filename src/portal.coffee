ceri = require "ceri/lib/wrapper"
module.exports = ceri
  mixins: [
    require "ceri/lib/props"
    require "ceri/lib/computed"
  ]
  props:
    target:
      type: String
  computed:
    cTarget:
      cbs: (target) ->
        for child in @_children
          target.appendChild(child)
      get: ->
        if @target
          selector = @target
          tmp = document.querySelector(selector)
          cwarn !tmp?, "no element found with ", selector
          return tmp if tmp?
        return document.body

  created: ->
    @_children = []
  connectedCallback: ->
    if @_isFirstConnect
      for child in @children
        @_children.push child
        @removeChild(child)
      @appendChild = (child) =>
        @_children.push child
        @cTarget.appendChild(child)
      @removeChild = (child) =>
        index = -1
        for c,i in @_children
          if c == child
            index = i
            break
        if index > -1
          @_children.splice(index,1)
          @cTarget.removeChild(child)
      @insertBefore = (child, ref) =>
        for c,i in @_children
          if c == ref
            @_children.splice(i,0,child)
            break
        @cTarget.insertBefore(child,ref)
      @replaceChild = (child, ref) =>
        for c,i in @_children
          if c == ref
            @_children.splice(i,1,child)
            break
        @cTarget.replaceChild(child,ref)
    else
      @$computed.getNotifyCb(path:"cTarget")()
  disconnectedCallback: ->
    for child in @_children
      child.remove()
