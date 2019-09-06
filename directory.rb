@students = [] # an empty array accessible to all methods

def input_students
  cohort = "november" # Passing to add_students along with names specified. Will change this by prompting user for input.
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  #gets the first name
  name = STDIN.gets.chomp
  #while the name is not empty, repeat this code
  while !name.empty? do
    #add the student hash to the students array
    #@students << {name: name, cohort: :november}
    add_students(name, cohort)
    puts "Now we have #{@students.count} students"
    #get another name from the user
    name = gets.chomp
  end
  puts "***Students entered successully!***"
end

def add_students(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def print_header
  puts "The students of Villains Acadamy"
  puts "-------------"
end

def print_student_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save student list to file"
  puts "4. Load students from another file"
  puts "9. Exit"
end

def show_students
  print_header
  print_student_list
  print_footer
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      puts "Please specify a file to save to..."
      file = STDIN.gets.chomp
      save_students(file)
    when "4"
      puts "Please specify a file to load from..."
      file = STDIN.gets.chomp
      load_students(file)
    when "9"
      exit
    else
      puts "I don't know what you meant, try again"
  end
end

def save_students(file)
  #open the file for writing
  open_file = File.open(file, "w")
  #iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    open_file.puts csv_line
  end
  open_file.close
  puts "*** Records saved successfully to #{file} ***"
end

def load_students(file = "students.csv")
  open_file = File.open(file, "r")
  open_file.readlines.each do |line|
  name, cohort = line.chomp.split(",")
    add_students(name, cohort)
  end
  open_file.close
  puts "*** #{file} loaded successfully ***"
end

def file_on_load # loads file passed from command line, else defaults to students.csv
  file = ARGV.first # first argument from the command line
  file = "students.csv" if file.nil?
  load_students(file)
  puts "Loaded #{@students.count} students from #{file}"
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

file_on_load
interactive_menu