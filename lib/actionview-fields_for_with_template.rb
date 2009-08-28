module ActionView
  module Helpers
    class FormBuilder
      def fields_for_with_template(record_or_name_or_array, *args, &block)
        options = args.extract_options!
        options[:child_index] = NumericSequence.new
        args << options
        unless options[:template_only]
          fields_for record_or_name_or_array, *args, &block
        end
        @template.fields_for "#{@object_name}[#{record_or_name_or_array.to_s.singularize}_attributes][new]", object.send(record_or_name_or_array).new, :index => "NEW_RECORD" do |f|
          @template.concat %|<div class="template" style="display:none">|, @proc
          block.call f
          @template.concat %|</div>|, @proc
        end
      end
    end
  end
end
