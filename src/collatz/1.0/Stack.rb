var redisHelper = require('./redisHelper');
var REDIS_URL = "redis://collatz-stack";

class Stack
  
  def initialize
    @client = redisHelper.connectToRedis(REDIS_URL);
    @array = []
  end

	def push(a,b)
    #		puts "Pushing #{a}n+#{b}"
    #    @array.insert(0, [a,b])
    @array << [a,b] 
	end
	
	def pop
#		puts "Popping..."
    @array.pop
	end
  
  def empty
    !@array.any?
  end
  
  def size
    @array.size.to_s
  end

  def top
    @array.at(@array.size-1)
  end
end