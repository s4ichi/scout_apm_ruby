module ScoutApm
  module LayerConverters
    class AllocationMetricConverter < ConverterBase
      def record!
        return unless scope_layer
        return unless ScoutApm::Instruments::Allocations::ENABLED

        meta = MetricMeta.new("ObjectAllocations", {:scope => scope_layer.legacy_metric_name})
        stat = MetricStats.new
        stat.update!(root_layer.total_allocations)
        metrics = { meta => stat }

        @store.track!(metrics)
        nil
      end
    end
  end
end
