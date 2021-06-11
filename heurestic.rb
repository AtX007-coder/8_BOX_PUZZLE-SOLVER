# frozen_string_literal: true

# The class that solves the puzzle
class Puzzle
  # Using getter and setter attributes
  attr_accessor :present_state, :solution_state, :num

  # To set the value of the variables with the parameters
  def initialize(present_state, solution_state, num)
    @present_state = present_state
    @solution_state = solution_state
    @num = num
  end

  # Main method to run all functions
  def main
    x = true
    while x == true
      print "Please select a choice:\n1. Input present state\n2. Input solution state\n"
      print "3. Display present state and solution state\n4. Get steps to solve\n5.Exit\n\n"
      choice = gets.chomp.to_i
      case choice
      when 1
        input_present_state
      when 2
        input_solution_state
      when 3
        display
      when 4
        show_steps(present_state, solution_state, num)
      when 5
        x = false
        puts 'Exiting...'
      else
        puts 'Wrong choice, try again'
      end
    end
  end

  # To display the present state and solution state
  def display
    puts 'Present state is:'
    present_state.each do |row|
      puts row.to_s
    end
    puts "\nSolution state is:"
    solution_state.each do |row|
      puts row.to_s
    end
    puts "\n"
  end

  # To input the present state
  def input_present_state
    puts "\nPlease enter the numbers in sequence:"
    (0...3).each do |i|
      (0...3).each do |j|
        print "[#{i}][#{j}]:"
        present_state[i][j] = gets.chomp.to_i
      end
    end
  end
 
  # To input the solution state
  def input_solution_state
    puts 'Please enter the numbers in sequence:'
    (0...3).each do |i|
      (0...3).each do |j|
        print "[#{i}][#{j}]:"
        solution_state[i][j] = gets.chomp.to_i
      end
    end
  end

  # To show how the puzzle can be solved
  def show_steps(present_state, solution_state, num)
    x = true
    accessed_state = []

    while x == true
      if present_state == solution_state
        puts 'No need to solve as present and solution state are equal'
        x = false
        break
      end

      puts 'Given present state is:'
      pretty_maker(present_state)
      accessed_state.push(present_state)

      puts "\n---------------------------------------------------------------------------"

      puts 'New possible combinations are:'
      combinations_generated = combination(present_state, num)
      count_generated = count_maker(present_state, solution_state, num)
      (0...combinations_generated.length).each do |i|
        pretty_maker(combinations_generated[i])
        puts "Heurestic value is #{count_generated[i]}"
        print "\n"
      end

      combinations_generated.each do |value|
        if accessed_state.include?(value)
          index = combinations_generated.index(value)
          combinations_generated.delete_at(index)
          count_generated.delete_at(index)
        end
      end

      puts '---------------------------------------------------------------------------'
      minimum = count_generated.min
      index = count_generated.find_index(minimum)
      got = combinations_generated[index]
      puts "Choosing heurestic value with lowest count: #{minimum}"
      pretty_maker(got)
      accessed_state.push(got)

      puts "\n---------------------------------------------------------------------------"

      if got == solution_state
        x = false
      else
        present_state = got
      end
    end
  end

  def pretty_maker(present_state)
    (0...present_state.length).each do |i|
      p present_state[i]
    end
  end

  def combination(present_state, num)
    moves = next_move(present_state, num)
    heurestic_store = []
    original_pos = getloc(present_state, num)

    (0...moves.length).each do |i|
      original_state = setter(present_state)
      generated_state = swap_place(original_state, moves[i], original_pos)
      heurestic_store.push(generated_state)
    end
    heurestic_store
  end

  def next_move(present_state, num)
    move_plot = []
    x_y = [0, 1] # x = 0, y = 1

    x_y.each do |i|
      -1.step(1, 2) do |j|
        loc = getloc(present_state, num)
        loc[i] += j
        move_plot.push(loc) unless loc[i].negative? || loc[i] > (present_state.length - 1)
      end
    end
    move_plot
  end

  def getloc(present_state, num)
    (0...present_state.length).each do |i|
      (0...present_state[i].length).each do |j|
        return [i, j] if present_state[i][j] == num
      end
    end
  end

  def setter(present_state)
    original = []
    temp = []
    (0...present_state.length).each do |i|
      (0...present_state[i].length).each do |j|
        temp.push(present_state[i][j])
      end
      original.push(temp)
      temp = []
    end
    original
  end

  def swap_place(instance_state, plot, original_pos)
    temp = instance_state[original_pos[0]][original_pos[1]]
    instance_state[original_pos[0]][original_pos[1]] = instance_state[plot[0]][plot[1]]
    instance_state[plot[0]][plot[1]] = temp
  
    instance_state
  end

  def count_maker(present_state, solution_state, num)
    count = []
    moves = next_move(present_state, num)
    heurestic_store = combination(present_state, num)
    (0...moves.length).each do |i|
      count.push(heurestic_count(heurestic_store[i], solution_state))
    end
    count
  end

  def heurestic_count(present_state, solution_state)
    heurestic = 0
    (0...present_state.size).each do |i|
      (0...present_state[i].size).each do |j|
        heurestic += 1 unless present_state[i][j] == solution_state[i][j]
      end
    end
    heurestic
  end
end

present_state = [
  [1, 2, 3],
  [0, 4, 6],
  [7, 5, 8]
]

solution_state = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 0]
]

num = 0

p = Puzzle.new(present_state, solution_state, num)
p.main
