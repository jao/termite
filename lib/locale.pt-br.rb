TIME_CONFIG = {
  :start => 9,
  :end => 18,
  :workday => 8,
  :lunch => {:upto6 => 900, :full => 3600},
  :fix_time => 10800
}

HOLIDAYS = [
  {:date => '01/01', :label => 'Ano novo'},
  {:date => '21/04', :label => 'Tiradentes'},
  {:date => '01/05', :label => 'Dia do Trabalho'},
  {:date => '07/09', :label => 'Independencia do Brasil'},
  {:date => '12/10', :label => 'Nossa Senhora Aparecida'},
  {:date => '02/11', :label => 'Finados'},
  {:date => '15/11', :label => 'Proclamacao da Republica'},
  {:date => '25/12', :label => 'Natal'}
]

# add the other variable holidays
x = 24; y = 5; year = Time.now.year
a = year % 19; b = year % 4; c = year % 7
d = (19*a+x) % 30
e = (2*b+4*c+6*d+y) % 7
if (d+e) > 9
  date = "#{"%02d" % (d+e-9)}/04"
else
  date = "#{"%02d" % (d+e+22)}/03"
end
date = "19/04" if date == "26/04"
date = "18/04" if date == "25/04" && a > 10 && d == 28
eastern_date = Time.parse("#{date}/#{year}")

other_holidays = [{:date => date, :label => "Pascoa"}]
other_holidays << {:date => (eastern_date.days(-48)).day_month, :label => "Carnaval"}
other_holidays << {:date => (eastern_date.days(-47)).day_month, :label => "Carnaval"}
other_holidays << {:date => (eastern_date.days(60)).day_month, :label => "Corpus Christi"}
HOLIDAYS.concat(other_holidays)

# sao paulo specific holidays
sp_br = [
  {:date => '09/07', :label => 'Nove de Julho'}
]
HOLIDAYS.concat(sp_br)