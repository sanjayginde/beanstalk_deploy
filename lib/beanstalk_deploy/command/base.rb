module BeanstalkDeploy
  module Command
    class Base
      def execute
      end

      protected

      attr_reader :printer
    end
  end
end
