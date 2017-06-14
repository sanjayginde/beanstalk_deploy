require "table_print"

module BeanstalkDeploy
  class Printer

    DATETIME_FORMAT = "%b %-d, %Y at %l:%M%P".freeze

    def line(line)
      puts line
    end

    def spacer
      line("\n")
    end

    def hash(hash)
      longest = hash.keys.map(&:to_s).max_by(&:length).length + 1
      hash.each do |key, value|
        formatted_key = "#{key.to_s}:".ljust(longest)
        formatted_value = format_value(value)
        line "#{formatted_key}\t#{formatted_value}"
      end
    end

    def table(objects, *fields)
      tp objects, *fields
    end

    private

    def format_value(value)
      if value.is_a? Date
        format_datetime value
      else
        value
      end
    end

    def format_datetime(datetime)
      datetime_in_zone = datetime.in_time_zone("Eastern Time (US & Canada)")
      "#{datetime_in_zone.strftime(DATETIME_FORMAT)} EST"
    end
  end
end
