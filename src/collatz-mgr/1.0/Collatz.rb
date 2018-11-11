require_relative 'Stack'
require 'sinatra'

set :bind, '0.0.0.0'

class Collatz
  def formatNumber(x)
    "2^#{Math.log2(x).to_int}"
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

  def kickOff
    puts "Adding initial seed"
    @stack.push(2,1)
  end

  def reset
    @stack.delete
    @stack.initCounter
    kickOff
  end

end

@@c = Collatz.new

get '/size' do
  @@c.displaySize
end

get '/' do
  "I'm healthy"
end

get '/reset' do
  @@c.reset
end


