class Entry < ActiveRecord::Base
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
  
  def self.remove args={}
    DB.execute("delete from timesheet #{conditions(args[:conditions])}")    
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
    rows = find({:conditions => ["date between #{time.start_of_day.to_i} and #{time.end_of_day.to_i}", "status = 'start'"], :order => 'date asc',})
    total_ut = 0
    if !rows.empty?
      rows.each do |row|
        start_row = start = row
        stop_row = find({:conditions => ["date between #{start_row.to_i} and #{time.end_of_day.to_i}", "status = 'stop'"], :order => 'date asc', :limit => 1}).first
        if stop_row.nil?
          stop_row = stop = time
        else
          stop = stop_row
        end
        total_ut += (stop_row.to_i - start_row.to_i)
      end
    end
    # lunch time and back
    lunchtime = find({:conditions => ["date between #{time.start_of_day.to_i} and #{time.end_of_day.to_i}", "(status = 'lunch' or status = 'back')"]})
    if !lunchtime.empty?
      lunchtime.each do |row|
        lunch = row if row.status == 'lunch'
        back = row if row.status == 'back'
      end
    end
    
    minimum_lunch_duration = (total_ut <= 14400) ? 0 : ((total_ut <= 22500) ? TIME_CONFIG[:lunch][:upto6] : TIME_CONFIG[:lunch][:full])
    lunch_duration = (!back.nil? && !lunch.nil?) ? back.to_i - lunch.to_i : (!lunch.nil?) ? time.to_i - lunch.to_i : 0
    req_lunch_duration = (lunch_duration >= minimum_lunch_duration) ? lunch_duration : minimum_lunch_duration
    lunch_duration = Time.at(lunch_duration + TIME_CONFIG[:fix_time])
    total = Time.at(total_ut - (((total_ut > 21600) || (!lunch.nil? && !back.nil?)) ? req_lunch_duration : 0) + TIME_CONFIG[:fix_time])
    req_lunch_duration = Time.at(req_lunch_duration + TIME_CONFIG[:fix_time])
    start = lunch = back = stop = lunch_duration = total = nil if total_ut == 0
    return [start, lunch, back, stop, lunch_duration, req_lunch_duration, total]
  end
end
