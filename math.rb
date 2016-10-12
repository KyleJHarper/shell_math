#!/usr/bin/ruby
# Hello.
Signal.trap('INT') { abort("\nYou got #{@correct} correct and #{@incorrect} incorrect.  Your grade is #{100 * @correct / (@correct + @incorrect)}%.") }

def new_numbers
  @num1 = Random.rand(0..@max)
  @num2 = Random.rand(0..@max)
end

require 'colorize'
abort("You must specify the max number to use, operator (add, subtract multiply, divide), and test time:  ./math.rb <biggest number> <operator> <time limit in minutes>") if ARGV.count != 3
Integer @max = ARGV[0].to_i
String  @operator = ARGV[1].to_s
String  @operator_symbol = ''
        @timer = true
        @timer = false if ARGV[2].to_i == 0
Integer @num1 = 0
Integer @num2 = 0
String  @answer = ''
Integer @correct = 0
Integer @incorrect = 0
        @answer_right = false
        @end = Time.now + (ARGV[2].to_i * 60)
Random.new

case @operator
  when 'add'
    @operator_symbol = '+'
  when 'subtract'
    @operator_symbol = '-'
  when 'multiply'
    @operator_symbol = 'x'
  when 'divide'
    @operator_symbol = '/'
  else
    abort("The operator you specified is invalid: #{@operator}")
end

new_numbers
while true
  if @timer && @end - Time.now < 0 then
    puts "Time is up!"
    abort("\nYou got #{@correct} correct and #{@incorrect} incorrect.  Your grade is #{100 * @correct / (@correct + @incorrect)}%.")
  end
  while @operator == 'subtract' && @num1 < @num2
    new_numbers
  end
  while @operator == 'divide' && (@num2 == 0 or @num1 % @num2 != 0)
    new_numbers
  end
  @answer_right = false
  printf("%d #{@operator_symbol} %d = ", @num1, @num2)
  @answer = STDIN.gets.chomp
  abort("\nYou got #{@correct} correct and #{@incorrect} incorrect.  Your grade is #{100 * @correct / (@correct + @incorrect)}%.") if @answer == 'quit'
  case @operator
    when 'add'
      @answer_right = true if @num1 + @num2 == @answer.to_i
    when 'subtract'
      @answer_right = true if @num1 - @num2 == @answer.to_i
    when 'multiply'
      @answer_right = true if @num1 * @num2 == @answer.to_i
    when 'divide'
      @answer_right = true if @num1 / @num2 == @answer.to_i
  end
  if ! @answer_right then
    puts "Incorrect.  Try again...".red
    @incorrect += 1
    next
  end
  puts "Correct!  Good job!".green
  puts ""
  @correct += 1
  new_numbers
end

