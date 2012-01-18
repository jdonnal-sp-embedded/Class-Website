module AdminHelper
  def createFlash(msg, type)
    "$('.flash').html(\"<div class='message #{type}'> <p> #{msg} </p> </div>\") \n $('.flash').slideDown().delay(2000).slideUp()"
  end
end
