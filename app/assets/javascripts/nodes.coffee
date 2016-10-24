# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jsUploader = (ele, rstmodal, path)->
  $ele = $(ele)
  $rstmodal = $(rstmodal)
  $ele.fileupload({
    url: path,
    dataType: 'json',
    type: 'POST',
    multipart: true,
    maxFileSize: 52428800,
    # acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
    formData: {parent_id: $ele.data('parentId')},
    add: (e, data)->
      data.context = $('<p/>').html("#{data.files[0].name}: <span class='text-warning'> uploading... </span>").appendTo($rstmodal.find('.modal-data'));
      data.submit();
      $rstmodal.find('.btn.btn-primary span').text('Uploading...');
      $rstmodal.find('.modal-data .text-info').hide();

    done: (e, data)->
      if data.result.status == 'OK'
        data.context.html("#{data.files[0].name}: <span class='text-success'> uploaded! </span>").appendTo($('#modal-uploader .modal-data'));
        $rstmodal.find('.btn.btn-default').text('Done');
        $rstmodal.find('.btn.btn-primary span').text('Add more file');
        location.reload();
      else
        data.context.html("#{data.files[0].name}: <span class='text-danger'>ERROR #{data.result.message} </span>").appendTo($('#modal-uploader .modal-data'));
        $rstmodal.find('.btn.btn-primary span').text('Re-upload');
  })

bindTokenAhead = (ele, data, populate)->
  $(ele).tokenInput(data,{
    prePopulate: populate
    })

window.bindTokenInput = bindTokenAhead
window.jsUploader = jsUploader

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
