TIME_CONFIG = {
  :start => 9,
  :end => 18,
  :workday => 8,
  :lunch => {:upto6 => 900, :full => 3600},
  :fix_time => Time.now.gmt_offset.abs + 3600
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

# state/region specific holidays
REGIONAL_HOLIDAYS = {
  :AC => [
    {:date => '23/01', :label => 'Dia do evangelico'},
    {:date => '15/06', :label => 'Aniversario do estado'},
    {:date => '06/08', :label => 'Inicio da Revolucao Acreana'},
    {:date => '05/09', :label => 'Dia da Amazonia'},
    {:date => '17/11', :label => 'Assinatura do Tratado de Petropolis'}
  ],
  :AL => [
    {:date => '24/06', :label => 'Sao Joao'},
    {:date => '29/06', :label => 'Sao Pedro'},
    {:date => '16/09', :label => 'Emancipacao politica'},
    {:date => '20/11', :label => 'Dia da consciencia Negra'}
  ],
  :AP => [
    {:date => '19/03', :label => 'Dia de Sao Jose'},
    {:date => '05/10', :label => 'Criacao do estado'},
    {:date => '20/11', :label => 'Dia da consciencia Negra'}
  ],
  :AM => [
    {:date => '05/09', :label => 'Elevacao do Amazonas a categoria de provincia'},
    {:date => '20/11', :label => 'Dia da consciencia Negra'},
    {:date => '08/12', :label => 'Dia de Nossa senhora da Conceicao'}
  ],
  :BA => [
    {:date => '28/06', :label => 'Piloes'},
    {:date => '02/07', :label => 'Independencia da Bahia'},
    {:date => '20/11', :label => 'Dia da consciencia Negra'}
  ],
  :DF => [
    {:date => '21/04', :label => 'Fundacao de Brasilia'},
    {:date => '30/11', :label => 'Dia do evangelico'}
  ],
  :ES => [
    {:date => '23/05', :label => 'Colonizacao do solo espirito-santense'},
    {:date => '28/10', :label => 'Dia do servidor publico'}
  ],
  :GO => [
    {:date => '28/10', :label => 'Dia do servidor publico'}
  ],
  :MA => [
    {:date => '28/07', :label => 'Adesao do Maranhao a Independencia do Brasil'},
    {:date => '08/12', :label => 'Dia de Nossa Senhora Conceicao'}
  ],
  :MT => [
    {:date => '20/11', :label => 'Dia da Consciencia Negra'}
  ],
  :MS => [
    {:date => '11/10', :label => 'Criacao do estado'}
  ],
  :MG => [
    {:date => '21/04', :label => 'Tiradentes'}
  ],
  :PA => [
    {:date => '15/08', :label => 'Adesao do Grao-Para a Independencia do Brasil'},
    {:date => '08/12', :label => 'Dia de Nossa Senhora Conceicao'}
  ],
  :PB => [
    {:date => '05/08', :label => 'Fundacao do Estado em 1585'}
  ],
  :PR => [
    {:date => '19/12', :label => 'Emancipacao politica'}
  ],
  :PE => [
    {:date => '06/03', :label => 'Revolucao Pernambucana de 1817'},
    {:date => '24/06', :label => 'Sao Joao'}
  ],
  :PI => [
    {:date => '13/03', :label => 'Dia da Batalha do Jenipapo'},
    {:date => '19/10', :label => 'Dia do Piaui'}
  ],
  :RJ => [
    {:date => '20/01', :label => 'Dia de Sao Sebastiao'},
    {:date => '23/04', :label => 'Dia de Sao Jorge'},
    {:date => '15/10', :label => 'Dia do comercio'},
    {:date => '28/10', :label => 'Dia do funcionario publico'},
    {:date => '20/11', :label => 'Dia da Consciencia Negra'}
  ],
  :RN => [
    {:date => '29/06', :label => 'Dia de Sao Pedro'},
    {:date => '03/10', :label => 'Martires de Cunhau e Uruacuu'}
  ],
  :RS => [
    {:date => '20/09', :label => 'Revolucao Farroupilha'}
  ],
  :RO => [
    {:date => '04/01', :label => 'Criacao do estado'},
    {:date => '18/06', :label => 'Dia do evangelico'}
  ],
  :RR => [
    {:date => '05/10', :label => 'Criacao do estado'}
  ],
  :SC => [
    {:date => '11/08', :label => 'Criacao da capitania, separando-se de Sao Paulo'}
  ],
  :SP => [
    {:date => '09/07', :label => 'Revolucao constitucionalista de 1932'},
    {:date => '20/11', :label => 'Dia da Consciencia Negra'}
  ],
  :SE => [
    {:date => '08/07', :label => 'Autonomia politica de Sergipe'}
  ],
  :TO => [
    {:date => '05/10', :label => 'Criacao do estado'}
  ],
}
HOLIDAYS.concat(REGIONAL_HOLIDAYS[REGION.to_sym]) if defined?(REGION) && !REGION.blank?
