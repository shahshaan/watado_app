WatadoApp::Application.routes.draw do
  resources :events

  get '/import_events' => 'Events#import' 
  
end
