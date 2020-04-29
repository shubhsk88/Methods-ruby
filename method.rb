module Enumerable
    def my_each
      for i in 0...length
        yield self[i]
      end
     self  
    end

  
  def my_each_with_index
        for i in 0...length
            yield self[i],i
        end
    self
    end

    def my_select
        new_arr=[]
        my_each do |num|
            if(yield num)
                new_arr.push(num)
            end
        end
        new_arr
    end
    
    def my_all?
        stat=true
        my_each do |num|
            if(!yield num)
               stat=false
            end
        end
        stat
    end

    def my_any?
        stat=false
        my_each do |num|
            if(yield num)
                stat=true
                
            end
        end
        stat
    end

    def my_none?
        stat=true
        my_each do |num|
            if(yield num)
                stat=false
            end
        end
        stat
    end

end


arr=[4,6,4]

# p arr.my_all?{|num| num%2==0} 
p %w[ant bear cat].any? { |word| word.length >= 4 }
