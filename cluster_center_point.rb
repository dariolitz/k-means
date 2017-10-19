require './point'
require './data_point'

class ClusterCenterPoint < Point
  @@counter = 0
  @@instances = []
  attr_reader :id, :x, :y, :name

  def initialize(x, y)
    @id = @@counter
    @name = "ccp_#{@id}"
    super(x, y)
    @@instances << self
    @@counter += 1
  end

  def move_to_center
    @x = dp_x_median
    @y = dp_y_median
  end

  def self.find(id)
    @@instances.each do |i|
      return i if i.id == id
    end
  end

  def self.all
    @@instances
  end


  def dps
    dps_arr = []
    DataPoint.all.each do |dp|
      dps_arr << dp if dp.ccp_id == @id
    end
    dps_arr
  end

  private

  def dp_x_median
    x_sum = 0
    dps.each do |dp|
      x_sum += dp.x
    end
    x_sum / dps.length
  end

  def dp_y_median
    y_sum = 0
    dps.each do |dp|
      y_sum += dp.y
    end
    y_sum / dps.length
  end
end
