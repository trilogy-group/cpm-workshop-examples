Rails.application.routes.draw do
  root 'quiz#menu'
  get 'quiz/index'
  get 'quiz/restart'
  post 'quiz/start'
  post 'quiz/answer'
  get 'quiz/games'
  get 'quiz/menu'
end