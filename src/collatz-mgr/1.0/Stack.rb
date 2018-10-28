require "redis"

REDIS_URL = "collatz-stack";
KEY = "collatz"
COUNTER = "counter"

class Stack
  
  def initialize
    puts "Welcome to Stack"
    puts "==> Initializing redis..."
    @redis = Redis.new(host: REDIS_URL);
  end

	def push(a,b)
#    puts "Pushing #{a}n+#{b}"
    pushed = false
    while not pushed
      begin
        @redis.rpush(KEY, [a,b].to_json) 
        pushed = true
      rescue => e
        puts "Exception: ", e
      end
    end
	end
	
	def pop
    v = @redis.rpop(KEY)
    a = JSON.parse(v)
    a
  end
  
  def empty
    @redis.llen(KEY) == 0
  end
  
  def size
    @redis.llen(KEY)
  end

  def top
    v = @redis.lindex(KEY, -1)
#    puts "Top: " + v
    a = JSON.parse(v)
    a
  end

  def delete
    @redis.del(KEY)
  end

  def initCounter
    @redis.set(COUNTER, 0)
  end

  def incCounter
    c = getCounter
    c = c+1
    @redis.set(COUNTER, c)
  end

  def getCounter
    @redis.get(COUNTER).to_i
  end
end