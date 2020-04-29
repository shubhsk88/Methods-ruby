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
               
end


arr=[1,4,5,6,4]

p arr.my_select{|num| num%2==0} 
