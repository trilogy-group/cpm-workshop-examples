Rails.application.routes.draw do
  get 'guesses/index'
  post 'guesses/guess'
  root 'guesses#index'
  get 'guesses/winner'
end
