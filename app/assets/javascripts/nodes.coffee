# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

bindTokenAhead = (ele, data, populate)->
  $(ele).tokenInput(data,{
    prePopulate: populate
    })

window.bindTokenInput = bindTokenAhead


$ ()->
  $('.taggable-tagsinput').tagsinput({
      maxTags: 5
      maxChars: 10
      trimValue: true
      allowDuplicates: false
      freeInput: true
  })
  $('.taggable-tagsinput').on('itemAdded', (item)->
    tagUrl = $(this).data('tagUrl')
    items = $(this).tagsinput('items')
    $.post(tagUrl, {tags: items}, ()=>)
  ).on('itemRemoved', (item)->
    tagUrl = $(this).data('tagUrl')
    items = $(this).tagsinput('items')
    $.post(tagUrl, {tags: items}, ()=>)
  )
