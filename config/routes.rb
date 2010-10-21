Infosystem::Application.routes.draw do
 
  resources :members do
    member do
      get :accept
      get :reject
    end
    collection do
      get :search
      get :registrations
      post :search
    end
    resources :subscriptions, :controller => :subscriptions, :only => [:index, :create, :destroy] do
      collection do
        get :change
      end
    end
    resources :fees, :controller => "membership_fees"
    resources :sections, :controller => "member_sections", :only => [:index]
    resources :projects, :controller => "member_projects", :only => [:index]
    resources :fieldworks, :controller => "member_fieldworks", :only => [:index]
  end

  resources :sections do
    collection do
      get :search
      post :search
    end
    resources :memberships, :controller => "section_memberships", :except => [:edit, :show] do
      collection do
        get :apply
        get :registrations
      end
    end
    resources :reports, :controller => "section_reports", :except => [:edit, :update, :show] do
      member do
        get :upload
        get :download
      end
    end
  end

  resources :projects do
    collection do
      get :search
      post :search
    end
    resources :participations, :controller => "project_participations", :except => [:edit, :show] do
      collection do
        get :apply
        get :registrations
      end
    end
    resources :reports, :controller => "project_reports", :except => [:index, :new, :edit, :update] do
       member do
        get :upload
        get :download
      end
    end
  end
  
  resources :fieldworks do
    collection do
      get :search
      post :search
    end
    resources :participations, :controller => "fieldwork_participations", :except => [:edit, :show] do
      collection do
        get :apply
        get :registrations
      end
    end
    resources :reports, :controller => "fieldwork_reports", :except => [:index, :new, :edit, :update] do
       member do
        get :upload
        get :download
      end
    end
  end

  resources :letters do
    member do
      get :download
    end
    collection do
      get :incoming
      get :outgoing
      get :search
      post :search
    end
  end
  
  resources :transfers do
    collection do 
      get :secret
      get :incoming
      get :outgoing
      get :search
      post :search
    end
  end

  resources :notifications do
    collection do
      get :search
      get :relevant
      get :send
    end
  end

  resources :tags do
    collection do
      get :search
      get :generate
    end
  end

  resource :user, :controller => "user" do
    member do
      get 'login'
      get 'logout'
    end
  end

  match ':controller/:action/:id'
  match ':controller/:action/'
  
  root :to => 'user#login'
end
