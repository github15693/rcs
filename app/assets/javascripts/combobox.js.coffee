#
# * Fuel UX Combobox
# * https://github.com/ExactTarget/fuelux
# *
# * Copyright (c) 2014 ExactTarget
# * Licensed under the BSD New license.
#

# -- BEGIN UMD WRAPPER PREFACE --

# For more information on UMD visit:
# https://github.com/umdjs/umd/blob/master/jqueryPlugin.js
((factory) ->
  if typeof define is "function" and define.amd

    # if AMD loader is available, register as an anonymous module.
    define ["jquery"], factory
  else

    # OR use browser globals if AMD is not present
    factory jQuery
  return
) ($) ->

  # -- END UMD WRAPPER PREFACE --

  # -- BEGIN MODULE CODE HERE --
  old = $.fn.combobox

  # COMBOBOX CONSTRUCTOR AND PROTOTYPE
  Combobox = (element, options) ->
    @$element = $(element)
    @options = $.extend({}, $.fn.combobox.defaults, options)
    @$dropMenu = @$element.find(".dropdown-menu")
    @$input = @$element.find("input")
    @$button = @$element.find(".btn")
    @$element.on "click.fu.combobox", "a", $.proxy(@itemclicked, this)
    @$element.on "change.fu.combobox", "input", $.proxy(@inputchanged, this)
    @$element.on "shown.bs.dropdown", $.proxy(@menuShown, this)

    # set default selection
    @setDefaultSelection()
    return

  Combobox:: =
    constructor: Combobox
    destroy: ->
      @$element.remove()

      # remove any external bindings
      # [none]

      # set input value attrbute in markup
      @$element.find("input").each ->
        $(this).attr "value", $(this).val()
        return


      # empty elements to return to original markup
      # [none]
      @$element[0].outerHTML

    doSelect: ($item) ->
      if typeof $item[0] isnt "undefined"
        @$selectedItem = $item
        @$input.val @$selectedItem.text()
      else
        @$selectedItem = null
      return

    menuShown: ->
      @resizeMenu()  if @options.autoResizeMenu
      return

    resizeMenu: ->
      width = @$element.outerWidth()
      @$dropMenu.outerWidth width
      return

    selectedItem: ->
      item = @$selectedItem
      data = {}
      if item
        txt = @$selectedItem.text()
        data = $.extend(
          text: txt
        , @$selectedItem.data())
      else
        data = text: @$input.val()
      data

    selectByText: (text) ->
      $item = $([])
      @$element.find("li").each ->
        if (@textContent or @innerText or $(this).text() or "").toLowerCase() is (text or "").toLowerCase()
          $item = $(this)
          false

      @doSelect $item
      return

    selectByValue: (value) ->
      selector = "li[data-value=\"" + value + "\"]"
      @selectBySelector selector
      return

    selectByIndex: (index) ->

      # zero-based index
      selector = "li:eq(" + index + ")"
      @selectBySelector selector
      return

    selectBySelector: (selector) ->
      $item = @$element.find(selector)
      @doSelect $item
      return

    setDefaultSelection: ->
      selector = "li[data-selected=true]:first"
      item = @$element.find(selector)
      if item.length > 0

        # select by data-attribute
        @selectBySelector selector
        item.removeData "selected"
        item.removeAttr "data-selected"
      return

    enable: ->
      @$element.removeClass "disabled"
      @$input.removeAttr "disabled"
      @$button.removeClass "disabled"
      return

    disable: ->
      @$element.addClass "disabled"
      @$input.attr "disabled", true
      @$button.addClass "disabled"
      return

    itemclicked: (e) ->
      @$selectedItem = $(e.target).parent()

      # set input text and trigger input change event marked as synthetic
      @$input.val(@$selectedItem.text()).trigger "change",
        synthetic: true


      # pass object including text and any data-attributes
      # to onchange event
      data = @selectedItem()

      # trigger changed event
      @$element.trigger "changed.fu.combobox", data
      e.preventDefault()

      # return focus to control after selecting an option
      @$element.find(".dropdown-toggle").focus()
      return

    inputchanged: (e, extra) ->

      # skip processing for internally-generated synthetic event
      # to avoid double processing
      return  if extra and extra.synthetic
      val = $(e.target).val()
      @selectByText val

      # find match based on input
      # if no match, pass the input value
      data = @selectedItem()
      data = text: val  if data.text.length is 0

      # trigger changed event
      @$element.trigger "changed.fu.combobox", data
      return


  # COMBOBOX PLUGIN DEFINITION
  $.fn.combobox = (option) ->
    args = Array::slice.call(arguments_, 1)
    methodReturn = undefined
    $set = @each(->
      $this = $(this)
      data = $this.data("fu.combobox")
      options = typeof option is "object" and option
      $this.data "fu.combobox", (data = new Combobox(this, options))  unless data
      methodReturn = data[option].apply(data, args)  if typeof option is "string"
      return
    )
    (if (methodReturn is `undefined`) then $set else methodReturn)

  $.fn.combobox.defaults = autoResizeMenu: true
  $.fn.combobox.Constructor = Combobox
  $.fn.combobox.noConflict = ->
    $.fn.combobox = old
    this


  # DATA-API
  $(document).on "mousedown.fu.combobox.data-api", "[data-initialize=combobox]", (e) ->
    $control = $(e.target).closest(".combobox")
    $control.combobox $control.data()  unless $control.data("fu.combobox")
    return


  # Must be domReady for AMD compatibility
  $ ->
    $("[data-initialize=combobox]").each ->
      $this = $(this)
      $this.combobox $this.data()  unless $this.data("fu.combobox")
      return

    return

  return


# -- BEGIN UMD WRAPPER AFTERWORD --

# -- END UMD WRAPPER AFTERWORD --

