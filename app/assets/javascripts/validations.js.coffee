jQuery ->
  $("form[data-validate ~= parsley]").parsley(
    classHandler:  (el) -> ($ el).closest("div.input")
    errorsWrapper: "<div class=\"parsley-errors-list\"></div>",
    errorTemplate: "<span></span>"
  )
