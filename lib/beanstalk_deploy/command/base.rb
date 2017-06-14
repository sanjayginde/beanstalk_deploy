module BeanstalkDeploy
  module Command
    class Base
      attr_reader :printer

      def execute
      end

      def log(msg)
        puts msg
      end

      def format_datetime(datetime)
        datetime_in_zone = datetime.in_time_zone("Eastern Time (US & Canada)")
        "#{datetime_in_zone.strftime(Beanstalk::Deploy::DATETIME_FORMAT)} EST"
      end
    end
  end
end
