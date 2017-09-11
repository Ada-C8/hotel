module Hotel
  module Dateable
    module InstanceMethods
      def get_date_range(check_in, check_out)
        (check_in ... check_out).to_a
      end
      #ability to do searchy things
      def finder(search_term, instance_variable, search_group)
        search_group.find_all{|element| element.send(instance_variable).include?(search_term)}
      end
    end
  end
end
