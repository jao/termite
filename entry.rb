class Entry
  attr_accessor :timesheet_id, :status, :unixtime, :comments
  def initialize args=[]
    return nil if args.empty?
    @timesheet_id = args[0].to_i
    @status = args[2]
    @unixtime = args[1].to_i
    @comments = args[3].to_s
  end
  
  def to_i; unixtime; end
  def to_s; status; end
  def date; Time.at(unixtime).strftime("%d/%m/%Y"); end
  def time; Time.at(unixtime).strftime("%H:%M"); end
  def datetime; Time.at(unixtime).strftime("%d/%m/%Y %H:%M"); end
  
  def status_message
    return case status
      when 'start': 'Working'
      when 'lunch': 'Having lunch'
      when 'back': 'Back working'
      when 'stop': 'Out for the day'
      else 'Confused'
    end
  end
  
  def self.find args={}
    sql = "select * from timesheet"
    sql += conditions(args[:conditions]) if args.key?(:conditions)
    sql += order(args[:order]) if args.key?(:order)
    sql += limit(args[:limit]) if args.key?(:limit)
    # puts sql
    rows = DB.execute(sql)
    if !rows.empty?
      rows.map{|row| new(row)}
    else
      []
    end
  end
  
  def self.last
    find({:order => 'date desc', :limit => 1}).first
  end
  
  def self.create args={}
    DB.execute("insert into timesheet (date, status) values(#{args[:date]},'#{args[:status]}')")
  end
  
  def self.update args={}
    DB.execute("update timesheet set #{fields_to_update(args[:fields])} #{conditions(args[:conditions])}")
  end
  
  def self.conditions(args); return build_sql(args, 'where', ' and '); end
  def self.order(args); return build_sql(args, 'order by'); end
  def self.limit(args); return build_sql(args, 'limit');end
  def self.fields_to_update(args); return build_sql(args); end
  
  def self.build_sql args, action='', delimiter=', '
    return '' if args == '' or (args.is_a?(Array) and args.empty?)
    " #{action} #{args.is_a?(Array) ? args.join(delimiter) : args}"
  end
  
  def self.report_daily time
    start = lunch = back = stop = lunch_duration = total = nil
    rows = find({:conditions => "date between #{time.start_of_day.to_i} and #{time.end_of_day.to_i}"})
    if !rows.empty?
      rows.each {|row| eval("#{row.status} = row")}
      stop = time if stop.nil?
      lunch_duration = (!back.nil? and !lunch.nil?) ? back.to_i - lunch.to_i : (!lunch.nil?) ? time.to_i - lunch.to_i : 0
      req_lunch_duration = (lunch_duration >= MINIMUM_LUNCH_DURATION) ? lunch_duration : MINIMUM_LUNCH_DURATION
      lunch_duration = Time.at(lunch_duration + FIX_TIME)
      total = Time.at(stop.to_i - start.to_i - req_lunch_duration + FIX_TIME)
    end
    return [start, lunch, back, stop, lunch_duration, total]
  end
end
