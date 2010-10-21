class InfoMailer < ActionMailer::Base

  def private_message(subject, body, sender, recipients)
    @subject = subject
    @body["body"] = body
    @body["sent_by"] = sender.username
    @recipients = recipients
    @from = sender.email
  end

  def notification(subject, body, recipients)
    @subject = subject
    @body = {:body => body, :recipients => recipients.collect {|r| r.username}}
    @from = "blabla@infosys.hmm"
  end

end
