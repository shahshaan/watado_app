WatadoApp::Application.routes.draw do
  resources :events
  
  get '/import_events' => 'Events#import' 
  
  get '/watado' => 'Events#watado'
  
end
