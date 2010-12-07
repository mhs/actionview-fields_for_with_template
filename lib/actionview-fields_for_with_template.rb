module ActionView
  module Helpers
    class FormBuilder
      def fields_for_with_template(record_or_name_or_array, *args, &block)
        options = args.extract_options!
        options[:child_index] = NumericSequence.new
        args << options

        result = fields_for record_or_name_or_array, *args, &block
        result += fields_for record_or_name_or_array, object.send(record_or_name_or_array).new, :child_index => "NEW_RECORD" do |f|
          @template.concat %|<script type="text/html" id="#{options[:id]}">|.html_safe
          block.call f
          @template.concat %|</script>|.html_safe
        end

        result
      end
    end
  end
end
