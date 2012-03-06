require 'set'
class Set

  #since the powerset of a given set is equal to the set of all subsets of that set,
  #it contains 2^n members, so instead of returning the actual powerset we return
  #an enumerator so it may be useful in cases of large sets
  def powerset
    as_array = to_a
    Enumerator.new do |yielder|
      (2** size).times do |x|

        #calculate the given binary representation
        #add the appropriate number of zero's to the front to maintain
        #the same length across all representations, so we can have
        #consistency with indices

        #make x a binary string representation
        x = x.to_s(2)
        #add the zeros to the front
        x = "0" * (size - x.length) + x

        #get the set corresponding to the given binary representation   
        #if the given set is {1, 2, 3, 4} and the binary is 0101, then we have
        #the elements {2, 4}, since their indexes match the indices of "1"'s
       
        add_array = []
        size.times do |y|
          add_array << as_array[y] if x[y] == "1"
        end
        yielder << (Set.new(add_array))

        #the above code in one line
        #yielder << Set.new((0..size).select {|i| as_array[i] if x[i] == "1"})
      end
    end
  end
end


#for testing
#add items to a new set
newset = Set.new
3.times do |y|
  newset.add(y)
end

#get it's powerset
newset.powerset.each do |x|
  puts x.inspect
end
