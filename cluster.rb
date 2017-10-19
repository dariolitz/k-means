class Cluster

  attr_reader :cluster_center_points, :data_points

  def initialize(cluster_center_points, data_points)
    @cluster_center_points = cluster_center_points
    @data_points = data_points
    delete_empty_ccps
  end

  def do_progress
    pre_cords = ccp_coordinates
    move_all_ccps_to_center
    assign_new_ccps
    post_cords = ccp_coordinates

    pre_cords == post_cords
  end

  private

  def ccp_coordinates
    all_ccp_cords = []
    @cluster_center_points.each do |ccp|
      cords = [ccp.x, ccp.y]
      all_ccp_cords << cords
    end
    all_ccp_cords
  end

  def delete_empty_ccps
    @cluster_center_points.delete_if { |ccp| ccp.dps.empty? }
  end

  def move_all_ccps_to_center
    @cluster_center_points.each &:move_to_center
  end

  def assign_new_ccps
    @data_points.each &:set_ccp
  end

end
