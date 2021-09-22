module VagrantPlugins
  module CommandServe
    class Mappers
      # Extracts a statebag from a Funcspec value
      class StateBag < Mapper
        def initialize
          inputs = [].tap do |i|
            i << Input.new(type: SDK::FuncSpec::Value) { |arg|
              arg.type == "hashicorp.vagrant.sdk.Args.StateBag" &&
                !arg&.value&.value.nil?
            }
            i << Input.new(type: Broker)
          end
          super(inputs: inputs, output: Client::StateBag, func: method(:converter))
        end

        def converter(proto, broker)
          Client::StateBag.load(proto.value.value, broker: broker)
        end
      end
    end
  end
end
