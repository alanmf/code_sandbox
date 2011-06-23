name_list_test = ["joe smith", "joe_smith", "joe-smith jones"]

#the rec_split_combiner is a recursive function that takes a string or array and a list of match_characters
#it splits each item in the array on these characters
#effectively returning an array of every individual item as per the match_chars

#EXAMPLE:
#rec_split_combiner("joe_smith jones", ["_", " "]) becomes ["joe", "smith", "jones"]

class PersonName
  attr_accessor :first
  attr_accessor :last
  attr_accessor :middle
  def initialize
    self.first  = ""
    self.last   = ""
    self.middle = ""
  end

  def ==(another_person)
    self.first == another_person.first
    self.middle == another_person.middle
    self.last == another_person.last
  end

  def like(another_person)
    #one name is like another if they have all the same characters
    self.alphabetize == another_person.alphabetize
  end

  def alphabetize
    (self.first + self.middle + self.last).split(//).sort.join
  end

end


def rec_split_combiner(names, match_chars)

  #if names is a string on the first pass make it an array
  names = [names] if names.is_a?(String)

  #zero case, return the recursive function
  if match_chars.empty?
    return names
  end
   
  mc = match_chars.last
  match_chars.pop

  new_names_array = []
  names.each do |n|
    #union the split array and our new array
    new_names_array = new_names_array | n.split(mc)
  end
  
  #call the function again
  rec_split_combiner(new_names_array, match_chars)
end

people = []
name_list_test.each do |name|
  person = PersonName.new
  names = rec_split_combiner(name, ['-', '_', ' '])
    first     = ""
    last      = ""
    secondary = ""
    tertiary  = ""
  case names.size
    when 1
      person.first = names.first
    when 2
      person.first = names.first
      person.last = names.last
    else
      person.first = names.first
      person.last = names.last
      person.middle = names[1,names.size - 2].join(' ')#.join(' ')
    end
    puts "#{first}  --  #{last}   -- #{secondary}  --  #{tertiary}"
    people << person
end


#puts people[1].like(people[2])
