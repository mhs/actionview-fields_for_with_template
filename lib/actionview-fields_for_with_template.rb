module ActionView
  module Helpers
    class FormBuilder
      def fields_for_with_template(record_or_name_or_array, *args, &block)
        options = args.extract_options!
        options[:child_index] = NumericSequence.new
        args << options
        
        records = object.send(record_or_name_or_array)
        if records.any?
          records.reject(&:new_record?).each do |record|
            nargs = args.dup
            nargs.unshift record
            @template.fields_for "#{@object_name}[#{record_or_name_or_array.to_s.singularize}_attributes][#{record.id}]", record, *nargs, &block
          end
        end
        
        @template.fields_for "#{@object_name}[#{record_or_name_or_array.to_s.singularize}_attributes][new][NEW_RECORD]", object.send(record_or_name_or_array).new do |f|
          @template.concat %|<div class="template" style="display:none">|, @proc.binding
          block.call f
          @template.concat %|</div>|, @proc.binding
        end
      end
    end
  end
end
