module CalendarsHelper
    def getPlantedDay(calendars)
        calendars.each do |calendar|
            return calendar if !calendar.planted_at.nil?
        end
    end

    def changeDateFormat(month)
        return "#{month.year}年#{month.mon}月"
    end
end
