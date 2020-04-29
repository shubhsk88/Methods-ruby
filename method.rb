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

    def my_count(counter=self.size)
        p_count=0
        if(block_given?)
            my_each do |num|
                if(yield num)
                    p_count+=1
                end
            
            end
            counter=p_count
        end
        counter
    end

    def my_inject(acc=0)
        
        my_each do |num|
            acc=yield(acc,num)

        end
        acc
    end
    def multiply_els
        
       res= my_inject(1) do |acc,num|
            acc*num
            
        end
        
    end  
    
    def my_map(prop=nil)
        new_arr=[]
        if(prop) 
            my_each do |num|
                new_arr.push(prop.call(num))
            end
        
        else
            my_each do |num|
              new_arr.push(yield num)
            end
        end

        new_arr
    
        
    end
       



        
            
        


end


arr=[4,6,3]

# p arr.my_all?{|num| num%2==0} 
# p arr.my_count(7)

# p (1..4).map { |i| i*i } 
# p arr.my_inject(0) { |sum, n| sum + n }  

p arr.multiply_els
prop=Proc.new{|x| x*2}
p arr.my_map(prop)