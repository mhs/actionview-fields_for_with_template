module ActionView
  module Helpers
    class FormBuilder
      def fields_for_with_template(record_or_name_or_array, *args, &block)
        options = args.extract_options!
        options[:child_index] = NumericSequence.new
        args << options
        fields_for record_or_name_or_array, *args, &block
        fields_for record_or_name_or_array, object.send(record_or_name_or_array).new, :child_index => "NEW_RECORD" do |f|
          @template.concat %|<div class="template" style="display:none">|
          block.call f
          @template.concat %|</div>|
        end
      end
    end
  end
end
