class ApplicationController < ActionController::Base
  helper :all
  layout 'application'

  # Check if user is logged in and has member authorization level
  def authorize
    if session[:user_id]
      unless Member.find(session[:user_id])
        session[:original_uri] = request.request_uri
        flash[:notice] = "Molimo logirajte se."
        redirect_to login_user_url
      end
    else
      redirect_to login_user_url
    end
  end

  # Check leadership of a group (section, project, fieldwork)
  def check_leadearship(group)
    if session[:user_id]
      unless group.find(params[:id]).leader_ids.include?(session[:user_id]) or session[:user_auth_level].to_i == Member::ROLE[:admin].to_i
        flash[:notice] = "Nemate potrebna prava za pristup akciji!"
        redirect_to(:controller => 'auth', :action => 'norights')
      end
    else
      redirect_to(:controller => 'auth' , :action => 'login' )
    end
  end

  # Wrapper for checking leadership of a section
  def check_if_section_leader
    check_leadearship(Section)
  end

  # Wrapper for checking leadership of a project
  def check_if_project_leader
    check_leadearship(Project)
  end

  # Wrapper for checking leadership of a fieldwork
  def check_if_fieldwork_leader
    check_leadearship(Fieldwork)
  end

  # Check user's authorization level
  def check_user_auth_level(level)
    if session[:user_id]
      unless session[:user_auth_level].to_i >= level.to_i
        flash[:notice] = "Nemate potrebna prava za pristup akciji!"
        redirect_to(:controller => 'auth', :action => 'norights')
      end
    else
      redirect_to(:controller => 'auth' , :action => 'login' )
    end
  end

  # Wrapper for checking root authorization level
  def check_if_root
    check_user_auth_level(Member::ROLE[:admin])
  end

  # Wrapper for checking administrative board authorization level
  def check_if_administrative_board
    check_user_auth_level(Member::ROLE[:adm_board])
  end

  # Wrapper for checking supervisory board authorization level
  def check_if_supervisory_board
    check_user_auth_level(Member::ROLE[:sup_board])
  end

  # Wrapper for checking leader authorization level
  def check_if_leader
    check_user_auth_level(Member::ROLE[:leader])
  end

  # Wrapper for checking member authorization level
  def check_if_member
    check_user_auth_level(Member::ROLE[:member])
  end

  # FIXME
  def check_if_item_in_possession
    if session[:user_id]
      unless Item.find(params[:id]).taker_id == session[:user_id]
        flash[:notice] = "Ne mozete osloboditi predmet koji vi niste zauzeli."
	redirect_to(:controller => 'auth' , :action => 'norights')
      end
    else
      redirect_to(:controller => 'auth' , :action => 'login' )
    end
  end

  # FIXME
  def check_if_self
    unless session[:user_id] == params[:id]
      redirect_to(:controller => :members, :action => :index)
      flash[:notice] = "Nemate potrebna prava za pristup akciji!"
    end
  end
 
  # FIXME 
  def check_if_destroy_self
    if session[:user_id] == params[:id]
      flash[:notice] = "Ne mozete izbrisati sebe!"
      redirect_to(:controller => request.path_parameters['controller'], :action => 'index')
    end
  end

end
