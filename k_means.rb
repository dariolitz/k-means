require './plot'
require './cluster'
require './data_point'
require './cluster_center_point'

def create_and_write_plot(cluster)
  kplot = KPlot.new(cluster, 800)
  kplot.write_to_file("output/file.png")
end

10.times do
  ClusterCenterPoint.new(Random.rand(1_000), Random.rand(1_000))
end

1000.times do
  DataPoint.new(Random.rand(10_000), Random.rand(10_000))
end

cluster = Cluster.new(ClusterCenterPoint.all, DataPoint.all)

Kernel.loop do
  if cluster.do_progress
    create_and_write_plot(cluster)
    break
  end
end

