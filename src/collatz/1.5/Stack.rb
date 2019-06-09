require "mongo"

STACK_URL = "collatz-mongodb"
KEY = "collatz"
COUNTER = "counter"
FINISHED = "finished"
MONGO_URL = "mongodb://stack-mongodb"

class Stack

  def initialize
    puts "Welcome to Stack"
    puts "==> Initializing connection to Mongo..."
    @mongo = Mongo::Client.new(MONGO_URL)
    @collatz = @mongo[:collatz]
  end

	def push(a,b)
#    puts "Pushing #{a}n+#{b}"
    pushed = false
    while not pushed
      begin
        @collatz.push([a,b].to_json)
        pushed = true
      rescue => e
        puts "Exception: ", e
      end
    end
	end

	def pop
    v = @collatz.pop()
    a = JSON.parse(v)
    a
  end

  def empty
    @collatz.count == 0
  end

  def size
    @collatz.count
  end

  def top
    v = @collatz.lindex(KEY, -1)
#    puts "Top: " + v
    a = JSON.parse(v)
    a
  end

  def delete
    @collatz.del(KEY)
  end

  def initCounter
    @mongo.counter.set(0)
  end

  def incCounter
    c = getCounter
    c = c+1
    @mongo.counter.set(c)
  end

  def getCounter
    @mongo.counter.get().to_i
  end

end
