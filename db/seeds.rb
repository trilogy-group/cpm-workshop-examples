require 'quiz'
require 'question'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Quiz.create(id: 1, name: 'States')
Question.create(quiz_id: 1, order: 1,
      question: 'What is the largest state?',
      option_a: 'Alaska',
      option_b: 'California',
      option_c: 'Hawaii',
      option_d: 'Texas',
      correct_answer: 'A'
)
Question.create(quiz_id: 1, order: 2,
      question: 'What state is farthest south?',
      option_a: 'Alaska',
      option_b: 'California',
      option_c: 'Hawaii',
      option_d: 'Texas',
      correct_answer: 'C'
)