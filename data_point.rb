require './point'
require './cluster_center_point'

class DataPoint < Point
  @@counter = 0
  @@instances = []
  attr_reader :name, :id, :ccp_id

  def initialize(x, y)
    @id = @@counter
    @name = "dp_#{@id}"
    super(x, y)
    set_ccp
    @@instances << self
    @@counter += 1
  end

  def self.find(id)
    @@instances.each do |i|
      return i if i.id == id
    end
  end

  def self.all
    @@instances
  end

  def ccp
    ClusterCenterPoint.find(ccp_id)
  end

  private

  def set_ccp
    @ccp_id = id_of_closest_ccp
  end

  def id_of_closest_ccp
    closest = ClusterCenterPoint.all.first
    closest_distance = distance_to(ClusterCenterPoint.all.first)
    ClusterCenterPoint.all.each do |ccp|
      distance = distance_to(ccp)
      if distance < closest_distance
        closest = ccp
        closest_distance = distance
      end
    end
    closest.id
  end
end
