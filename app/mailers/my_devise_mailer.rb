class MyDeviseMailer < Devise::Mailer
  # これでは動かない
  # https://github.com/heartcombo/devise/issues/4842
  # default template_path: 'users/mailer'

  def headers_for(action, opts)
    super.merge!(template_path: 'users/mailer')
  end

  def reset_password_instructions(record, token, opts = {})
    # attr_accessorに設定したControllerの値を取り出し、テンプレートで使えるようインスタンス変数にセット
    @controller_value = record.controller_value

    super(record, token, opts)
  end

  protected

  def subject_for(key)
    # 件名の先頭に、インスタンス変数に入れた controller_value をセット
    subject = super(key)
    "[#{@controller_value}] #{subject}"
  end
end
