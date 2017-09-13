class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_topic.subject
  #
  # 引数でtopicを追加、topicの情報を引数として渡す。
  def sendmail_topic(topic)
    @topic = topic

    mail to: "kouhei.w.56@gmail.com",
      subject: '【faceもどき】作品が投稿されました'
  end
end
