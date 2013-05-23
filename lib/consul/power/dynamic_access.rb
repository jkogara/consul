module Consul
  module Power
    module DynamicAccess

      module InstanceMethods

        def for_record(*args)
          send(name_for_record(*args))
        end

        def include_record?(*args)
          adjective, record = Util.adjective_and_argument(*args)
          include?(name_for_record(*args), record)
        end

        def include_record!(*args)
          adjective, record = Util.adjective_and_argument(*args)
          include!(name_for_record(*args), record)
        end

        def name_for_model(*args)
          adjective, model_class = Util.adjective_and_argument(*args)
          collection_name = model_class.name.underscore.gsub('/', '_').pluralize
          [adjective, collection_name].select(&:present?).join('_')
        end

        def for_model(*args)
          send(name_for_model(*args))
        end

        def include_model?(*args)
          include?(name_for_model(*args))
        end

        def include_model!(*args)
          include!(name_for_model(*args))
        end

        def name_for_record(*args)
          adjective, record = Util.adjective_and_argument(*args)
          name_for_model(adjective, record.class)
        end

      end

      module ClassMethods

        def for_model(*args)
          if current
            current.for_model(*args)
          else
            adjective, model = Util.adjective_and_argument(*args)
            model
          end
        end

        def include_model?(*args)
          if current
            current.include_model?(*args)
          else
            true
          end
        end

        def include_model!(*args)
          if current
            current.include_model!(*args)
          else
            true
          end
        end

        def for_record(*args)
          if current
            current.for_record(*args)
          else
            adjective, record = Util.adjective_and_argument(*args)
            record.class
          end
        end

        def include_record?(*args)
          if current
            current.include_record?(*args)
          else
            true
          end
        end

        def include_record!(*args)
          if current
            current.include_record!(*args)
          else
            true
          end
        end

      end

    end
  end
end