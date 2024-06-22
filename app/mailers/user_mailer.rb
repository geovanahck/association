
class UserMailer < ApplicationMailer
  default from: 'admin@admin.com'
  def balance_report(user)
     attachments['People.csv'] = {mime_type: 'text/csv', content: Person.to_excel}
     mail(to: user.email, subject:   "People Details-#{Date.today}.csv")
  end
end