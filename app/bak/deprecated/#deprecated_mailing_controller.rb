class MailingController < ApplicationController
  layout 'standard'
  before_filter :authorize

  def index
  end

  def send_tagz_mail
    @project = Project.find(params[:id])
    if (params[:subject] and params[:body] and params[:recipients])
    @recipients = case params[:recipients]
    when "participants" then @project.participants.collect{|m| m.email}
    when "leaders" then @project.leaders.collect{|m| m.email}
    end
    @sender = Member.find(session[:user_id])
    email = NotificationMailer.create_notification(params[:subject], params[:body], @sender , @recipients)
    render(:text => "<pre>" + email.encoded + "</pre>")
    else
    render :action => 'send_mail'
    end
  end

  def send_mass_mail
    unless params[:recipients]
    if params[:keyword]==nil or params[:keyword].empty?
    @recipients = Member.all
    else
    @recipients = Member.all(:conditions => ["first_name LIKE ? OR last_name LIKE ?" , "%#{params[:keyword]}%" , "%#{params[:keyword]}%"])
    end
    end

    if (params[:recipients] or params[:subject] or params[:body])
    @sender = Member.find(session[:user_id])
    @recipients = params[:recipients].collect{|id| Member.find(id).email}
    @mail = Mail.new()
    @mail.sender_email = @sender.email
    @mail.recipients = @recipients
    @mail.subject = params[:subject]
    @mail.body = params[:body]
    @sender.mails << @mail
    @sender.save
    email = NotificationMailer.create_notification(params[:subject], params[:body], @sender , @recipients)
    render(:text => "<pre>" + email.encoded + "</pre>")
    else
    render :action => 'send_mass_mail'
    end
  end

  def send_group_mail
    if (params[:subject] and params[:body] and params[:recipients])
    @recipients = case params[:recipients]
    when "upravni" then Member.all(:conditions => [ "auth_level = ?", 4]).collect{|m| m.email}
    when "nadzorni" then Member.all(:conditions => [ "auth_level = ?", 3]).collect{|m| m.email}
    when "voditelji" then Member.all(:conditions => [ "auth_level = ?", 2]).collect{|m| m.email}
    when "svi" then Member.all.collect{|m| m.email}
    end
    @sender = Member.find(session[:user_id])
    member.mail = Mail.new(:sender_id => @sender.id, :sender_email => @sender.email, :recipients => @recipients, :subject => params[:subject], :body => params[:body])
    member.save
    email = NotificationMailer.create_notification(params[:subject], params[:body], @sender , @recipients)
    render(:text => "<pre>" + email.encoded + "</pre>")
    else
    render :action => 'send_group_mail'
    end
  end

  def show_archives
    @mails = Mail.all
  end

end
