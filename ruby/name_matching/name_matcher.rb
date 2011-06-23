#NAME-MATCHING v.1, attempt to identify similar and equivalent names in a list of them
#This script does several things,

#1 - reads data in from a file that is formatted as "string","string1","string2","...etc and sanitizes the data

#2 - removes special characters from the names and splits on spaces, returning an array, e.g. "joe_smith jones" becomes ["joe", "smith", "jones"] and "clint eastwood" becomes ["clint", "eastwood"]

#3 - create a 'PersonName' object based on the names that were read in, sanitized, and split, then add that object to an array of objects called 'People'

#4 - create methods to identify how similar a name is to another, and if they are equivalent

#current goal:
  #iterate over the list of names and determine which are equivalent, and which are similar, in varying degrees 

#future goals:
  #abstract the data from names to just strings
  #optimize to work on monstrous data sets


#define the PersonName class and it's associated methods
class PersonName
  attr_accessor :first
  attr_accessor :last
  attr_accessor :middle
  attr_accessor :original_name

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


#the rec_split_combiner is a recursive function that takes a string or array and a list of match_characters
#it splits each item in the array on these characters
#effectively returning an array of every individual item as per the match_chars

#EXAMPLE:
#rec_split_combiner("joe_smith jones", ["_", " "]) becomes ["joe", "smith", "jones"]
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


#the main function that iterates over the names, creates person objects, and adds them to an array name 'people'
def create_people(name_list)
  people = []
  name_list.each do |name|
    person = PersonName.new
    #store the original name
    person.original_name = name
    #define the special characters that may be contained in names that we should split on
    names = rec_split_combiner(name, [',', '-', '_', ' '])
    case names.size
      when 1
        person.first = names.first
      when 2
        person.first = names.first
        person.last = names.last
      else
        person.first = names.first
        person.last = names.last
        #form the middle name from anything in the array that's not the first and last
        person.middle = names[1,names.size - 2].join(' ')#.join(' ')
      end
      #add the person to the people array
      people << person
  end
end

def get_name_list(filename)
  #open the file and read it in (it's just one line)
  f = File.open(filename).each_line { |s| @list=s }
  f.close
  
  #split the list on ",", we can't just have commas because name might have them
  @list = @list.split('","')

  #sanitize the data
    #remove doubles quotes from strings
    #remove spaces from beginning and end of string
    #downcase the string
  @list.each do |name|
    name.gsub!('"', "") if name.include?('"')
    name.downcase!
    name.rstrip!
    name.lstrip!
  end
  return @list
end

get_name_list('sample_data.txt') #returns @list

people = create_people(@list)

