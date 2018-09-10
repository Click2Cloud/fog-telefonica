require 'fog/telefonica/models/model'

module Fog
  module Orchestration
    class Telefonica
      class Template < Fog::Telefonica::Model
        %w(format description template_version parameters resources content).each do |a|
          attribute a.to_sym
        end
      end
    end
  end
end
