# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
(($) ->
  $.fn.extend limiter: (limit, elem) ->
    setCount = (src, elem) ->
      chars = src.value.length
      if chars > limit
        src.value = src.value.substr(0, limit)
        chars = limit
      elem.html limit - chars
    $(this).on "keyup focus", ->
      setCount this, elem

    setCount $(this)[0], elem

) jQuery
elem = $("#chars")
$("textarea").limiter 140, elem
