class PostMailer < ApplicationMailer
  default from: "ingesoft@unal.edu.co"

  def notification(users,post)
    @post = post
    mail(to: users.join(","),subject: "new question")
  end

end
