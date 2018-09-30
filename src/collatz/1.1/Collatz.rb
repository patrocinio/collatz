require_relative 'Stack'
require 'sinatra'

set :bind, '0.0.0.0'

class Collatz
  def formatNumber(x)
    "2^#{Math.log2(x).to_int}"
  end

  def process(e)
    a = oa = e[0]
    b = ob = e[1]
    #  puts "Popped: #{oa}n+#{ob}"
  
    while true 
      #    puts "Processing: #{a}n+#{b}"
      if a.even?
        if b.even?
          a = a/2
          b = b/2
        
          if a < oa
            puts "==> Completed #{formatNumber(oa)}n+#{formatNumber(ob)} --> #{formatNumber(a)}n+#{formatNumber(b)}"
            @finished = @finished + 1
            break
          end
        else
          a = 3*a
          b = 3*b+1
        end # a.even
      else
        @stack.push(2*oa, oa+ob)
        @stack.push(2*oa, ob)
        break
      end
    end
  end

  def displaySize
    e = @stack.top 
    a = e[0]
    b = e[1]

    perc = @finished*100 / @stack.size.to_i
    "Array size: " + @stack.size.to_s + " finished: " + @finished.to_s + \
      " ( " + perc.to_s + "%) top: " + formatNumber(a)
  end

  def displayStatus
    @stCount = @stCount + 1
    if @stCount == 1000
      size = displaySize
      puts size
      STDOUT.flush
      @stCount = 0
    end  
  end

  def go 
    count = 0
    displaySize
    while !@stack.empty and count < 1000000
      displayStatus
      e = @stack.pop
      process e
      count = count+1
    end
    puts "Done"
  end

  def run
    displaySize
    go
  end

  def initialize
    puts "initialize"
    @stack = Stack.new
    @stack.push(2,1)
    @stCount=0
    @finished=0
    puts "Spawing a thread..."
    Thread.new { run }
  end
end

@@c = Collatz.new

get '/size' do
  @@c.displaySize
end

get '/' do
  "I'm healthy"
end


