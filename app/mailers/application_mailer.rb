# app/mailers/application_mailer.rb
class ApplicationMailer < ActionMailer::Base
  default from: "admin@admin.com"
  layout 'mailer'
end
