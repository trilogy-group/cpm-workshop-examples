Rails.application.routes.draw do
  root 'quiz#index'
  get 'quiz/index'
  get 'quiz/restart'
  post 'quiz/start'
  post 'quiz/answer'
end