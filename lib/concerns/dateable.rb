module Hotel
  module Dateable
    module InstanceMethods
      def get_date_range(check_in, check_out)
        (check_in ... check_out).to_a
      end
    end
  end
end
