module Formatter

  DATE_FORMAT = "%d/%m/%Y"

  def Formatter.format_date(date)
    (date != NIL) ? date.strftime(DATE_FORMAT) : NIL
  end


end