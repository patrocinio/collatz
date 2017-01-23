require_relative 'Stack'
require 'sinatra'

class Collatz
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
            puts "==> Completed #{oa}n+#{ob} --> #{a}n+#{b}"
            @finished = @finished + 1
            break
          end
        else
          a = 3*a
          b = 3*b+1
        end # a.even
      else
        @stack.push(2*oa, ob)
        @stack.push(2*oa, oa+ob)
        break
      end
    end
  end

  def displaySize
    puts "Array size: " + @stack.size.to_s + " finished: " + @finished.to_s
  end

  def displayStatus
    @stCount = @stCount + 1
    if @stCount == 1000
      displaySize
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
    run
  end
end

@@c = Collatz.new

get '/' do
#  run
end


