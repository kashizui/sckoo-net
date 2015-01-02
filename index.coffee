TRUE_WIDTH = 1003
WHITE_WIDTH = 94
BLACK_WIDTH = 63
BLACK_HEIGHT_FRACTION = 0.60
KEY_X_OFFSETS =
  "c1":   4
  "c#1":  73
  "d1":   104
  "d#1":  171
  "e1":   204
  "f1":   304
  "f#1":  371
  "g1":   404
  "g#1":  471
  "a1":   504
  "a#1":  571
  "b1":   604
  "c2":   704
  "c#2":  773
  "d2":   804
  "d#2":  871
  "e2":   904

$.fn.textWidth = ->
  self = $(this)
  children = self.children()
  calculator = $("<span style=\"display: inline-block;\">")
  width = undefined
  children.wrap calculator
  width = children.parent().width() # parent = the calculator wrapper
  children.unwrap()
  width

$(document).ready ->
  size =
    width: $("#piano").width()
    height: $("#piano").height()
  scale = size.width / TRUE_WIDTH

  # Scale widths and offsets
  WHITE_WIDTH *= scale
  BLACK_WIDTH *= scale
  for own key of KEY_X_OFFSETS
    KEY_X_OFFSETS[key] *= scale

  # Prepare reset function
  reset = ->
    newOffset =
      top: ($(window).height() - size.height) / 2
      left: ($(window).width() - size.width) / 2

    $("#piano, #overlay, #links").offset newOffset
  $(window).resize reset

  # process links
  $links = $("#links").find ".chord-link"
  linkHeight = size.height * BLACK_HEIGHT_FRACTION / $links.length
  linkTopOffset = 0
  for link in $links
    $link = $ link
    chord = $link.data("chord").split(",")

    $clickArea = $("<a></a>")
      .css
        position: "absolute"
        display: "block"
        "z-index": 2
        width: size.width
        height: linkHeight
        top: linkTopOffset + "px"
        left: 0
      .attr
        href: $link.data("href")
      .appendTo($("#links"))

    for letter, i in $link.html()
      $letter = $("<div></div>")
        .css
          position: "absolute"
          display: "block"
        .html(letter)
        .addClass("chord-letter")
        .appendTo($("#links"))

      keyWidth = if chord[i].search('#') < 0 then WHITE_WIDTH else BLACK_WIDTH
      $letter.css
        top: (linkTopOffset + (linkHeight - $letter.height()) - 5 ) + "px"
        left: (KEY_X_OFFSETS[chord[i]] + (keyWidth - $letter.width())/2 ) + "px"
        height: linkHeight
        display: "none"

    linkTopOffset += linkHeight

  # Execute now
  reset()
  $("#piano").fadeIn "slow", ->
    # when fade in complete
    $("#overlay").show()
    $(".chord-letter").fadeIn "slow"
