module Formatter

  DATE_FORMAT = "%d/%m/%Y"
  DATETIME_FORMAT = "%d/%m/%Y - %H:%M"

  def Formatter.format_date(date)
    (date != NIL) ? date.strftime(DATE_FORMAT) : NIL
  end

  def Formatter.format_datetime(datetime)
    (datetime != NIL) ? datetime.strftime(DATETIME_FORMAT) : NIL
  end

end