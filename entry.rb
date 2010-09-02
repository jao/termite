class Entry # < ActiveRecord::Base
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
  def to_time; Time.at(unixtime); end
  def date; Time.at(unixtime).strftime("%d/%m/%Y"); end
  def time; Time.at(unixtime).strftime("%H:%M"); end
  def datetime; Time.at(unixtime).strftime("%d/%m/%Y %H:%M"); end
  
  def to_list
    [
      timesheet_id.to_s.right(7),
      status.left(8),
      date.left(12),
      time.right(6).tc(cpick({:status => status, :date => unixtime})),
      comments.left(75)
    ].join('|')
  end
  
  def status_message
    return case status
      when 'start': 'Working'
      when 'lunch': 'Having lunch'
      when 'back': 'Back working'
      when 'stop': 'Out for the day'
      else 'Confused'
    end
  end
  
  def method_missing methodname, *args
    return (methodname.to_s.gsub('?','') == status) if methodname.to_s =~ /\?$/i
    return false
  end
  
  def self.header
    [
      'id'.right(7),
      'status'.left(8),
      'date'.left(12),
      'time'.left(7),
      'comments'.left(75)
    ].join('|').black_white
  end
  
  def self.find *args
    args = args.extract_options!
    sql = "select * from timesheet"
    sql += conditions(args[:conditions]) if args.key?(:conditions)
    sql += order(args[:order]) if args.key?(:order)
    sql += limit(args[:limit]) if args.key?(:limit)
    rows = DB.execute sql
    if !rows.empty?
      rows.map{|row| new(row)}
    else
      []
    end
  end
  
  def self.last
    find(:order => 'date desc', :limit => 1).first
  end
  
  def self.create *args
    args = args.extract_options!
    DB.execute "insert into timesheet (date, status, comments) values(#{args[:date]},'#{args[:status]}','#{args[:comments]}')"
  end
  
  def self.update *args
    args = args.extract_options!
    DB.execute "update timesheet set #{fields_to_update(args[:fields])} #{conditions(args[:conditions])}"
  end
  
  def self.remove *args
    args = args.extract_options!
    DB.execute "delete from timesheet #{conditions(args[:conditions])}"
  end
  
  def self.conditions(args); build_sql(args, 'where', ' and '); end
  def self.order(args); build_sql(args, 'order by'); end
  def self.limit(args); build_sql(args, 'limit'); end
  def self.fields_to_update(args); build_sql(args); end
  
  def self.build_sql args, action='', delimiter=', '
    return '' if args == '' || (args.is_a?(Array) && args.empty?)
    " #{action} #{args.is_a?(Array) ? args.join(delimiter) : args}"
  end
  
  def self.report time
    start = lunch = back = stop = lunch_duration = total = nil
    periods = []
    rows = find :conditions => ["date between #{time.start_of_day.to_i} and #{time.end_of_day.to_i}", "status = 'start'"], :order => 'date desc'
    if !rows.empty?
      rows.each do |row|
        start_row = start = row
        stop_row = find(:conditions => ["date > #{start.to_i}", "status = 'stop'"], :order => 'date asc', :limit => 1).first
        if stop_row.nil?
          stop_row = stop = time
        else
          stop = stop_row
        end
        total_ut = (stop_row.to_i - start_row.to_i)
        
        # lunch time and back
        lunchtime = find :conditions => ["date between #{start.to_i} and #{stop.to_i}", "(status = 'lunch' or status = 'back')"]
        if !lunchtime.empty?
          lunchtime.each do |row|
            lunch = row if row.lunch?
            back = row if row.back?
          end
        end
        lunch_duration = (!back.nil? && !lunch.nil?) ? back.to_i - lunch.to_i : (!lunch.nil?) ? time.to_i - lunch.to_i : 0
        minimum_lunch_duration = [0,6].include?(time.wday) || total_ut <= 22500 ? 0 : TIME_CONFIG[:lunch][:full]
        req_lunch_duration = (lunch_duration >= minimum_lunch_duration) ? lunch_duration : minimum_lunch_duration
        lunch_duration = Time.at(lunch_duration + TIME_CONFIG[:fix_time])
        total = Time.at(total_ut - ((total_ut > 22500) || (!lunch.nil? && !back.nil?) ? req_lunch_duration : 0) + TIME_CONFIG[:fix_time])
        req_lunch_duration = Time.at(req_lunch_duration + TIME_CONFIG[:fix_time])
        start = lunch = back = stop = lunch_duration = total = nil if total_ut == 0
        periods << [start, lunch, back, stop, lunch_duration, req_lunch_duration, total]
      end
    end
    
    return periods
  end
end
