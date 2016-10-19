$ ()->
  $('form.formLabel input[type="checkbox"]').on 'click', ()->
    $('form.formLabel').submit()
