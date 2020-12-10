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
      question: 'What year was AWS launched?',
      option_a: '2005',
      option_b: '2006',
      option_c: '2007',
      option_d: '2008',
      correct_answer: 'B'
)
Question.create(quiz_id: 1, order: 2,
      question: 'Which AWS service was not among the first three launched?',
      option_a: 'IAM',
      option_b: 'EC2',
      option_c: 'S3',
      option_d: 'SQS',
      correct_answer: 'A'
)
Question.create(quiz_id: 1, order: 3,
      question: 'What is the name of the AWS Graph Database offering?',
      option_a: 'RDS',
      option_b: 'Mercury',
      option_c: 'Neptune',
      option_d: 'Pluto',
      correct_answer: 'C'
)