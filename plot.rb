require 'gruffy'

class KPlot < Gruffy::Scatter

  attr_accessor :cluster_center_points

  def initialize(cluster, cc)
    @cluster_center_points = cluster.cluster_center_points
    super(cc)
    @data = []
    @marker_font_size = 10.0
    @cluster_center_points.each do |ccp|
      data("#{ccp.name}_data_points", get_x_values(ccp.dps), get_y_values(ccp.dps))
      data(ccp.name, [ccp.x], [ccp.y], "#00FFFF")
    end
    @file = 'output/graph.png'
  end

  def write_to_file(out = @file)
    @file = out
    write(@file)
  end

  def open_file
    `xdg-open #{@file}`
  end

  def get_x_values(points)
    x_values = []
    points.each do |p|
      x_values << p.x
    end
    x_values
  end

  def get_y_values(points)
    y_values = []
    points.each do |p|
      y_values << p.y
    end
    y_values
  end
end
