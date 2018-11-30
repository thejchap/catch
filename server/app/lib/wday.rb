module Wday
  SUN = SUNDAY    = :sunday
  MON = MONDAY    = :monday
  TUE = TUESDAY   = :tuesday
  WED = WEDNESDAY = :wednesday
  THU = THURSDAY  = :thursday
  FRI = FRIDAY    = :friday
  SAT = SATURDAY  = :saturday

  ALL = [SUN, MON, TUE, WED, THU, FRI, SAT].freeze

  def self.[](i)
    ALL[i]
  end
end
