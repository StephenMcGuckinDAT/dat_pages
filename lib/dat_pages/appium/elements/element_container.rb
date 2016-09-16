require_relative '../../errors'

module DATPages

  module Appium::PageObjects::ElementContainer
    # TODO: Throw an error if the driver hasnt been started

    # valid find_bys = [:id, :xpath, :text]
    # def element(name, locator, find_by=:id)
    #   if find_by == :text
    #     class_eval(%Q(private def #{name.to_s};$driver.find("#{locator}");end))
    #   else
    #     class_eval(%Q(private def #{name.to_s};$driver.find_element("#{find_by}".to_sym, "#{locator}");end))
    #   end
    # end

    def element(*args)
      args = parse_element_args(args)
      class_eval(%Q(private def #{args[:name].to_s}; @#{args[:name].to_s} ||= Element.new("#{args[:locator]}", self, "#{args[:find_by].nil? ? args[:find_by] : args[:find_by].to_sym}");end))
    end

    #
    # def ios_element(name, uielement, value)
    #   class_eval(%Q(private def #{name.to_s}; $driver.ele_by_json_visible_exact("#{uielement}", "#{value}");end))
    # end

    def section(*args)
      args = parse_section_args args
      class_eval(%Q(private def #{args[:name].to_s};@#{args[:name].to_s} ||= #{args[:class_name]}.new("#{args[:locator]}", self, "#{args[:find_by].nil? ? args[:find_by] : args[:find_by].to_sym}");end))
    end

    # note: this will probably change to its own defined method later
    alias_method :page, :section

    # define a button using the value as the locator
    # @param [String] value the value of the button you are looking for
    # def button(name, value)
    #   class_eval(%Q(private def #{name.to_s}; $driver.button("#{value}"); end))
    # end
    private

    def parse_element_args(args)
      case args.length
        when 2
          {name: args[0], locator: args[1]}
        when 3
          {name: args[0], find_by: args[1], locator: args[2]}
        else
          raise ArgumentError.new("Wrong number of arguments. Expected 2 or 3, got #{args.length}")
      end
    end

    def parse_section_args(args)
      case args.length
        when 3
          {name: args[0], class_name: args[1], locator: args[2]}
        when 4
          {name: args[0], class_name: args[1], find_by: args[2], locator: args[4]}
        else
          raise ArgumentError.new("Wrong number of arguments. Expected 3 or 4, got #{args.length}")
      end
    end

  end


end