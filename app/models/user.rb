class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  devise :database_authenticatable, :recoverable, :validatable

  include DeviseDeliverLater

  attr_accessor :controller_value

  def self.find_or_initialize_with_errors(required_attributes, attributes, error = :invalid)
    # DeviseのMailerがメールを送信する場合は、いずれもこのクラスメソッドが使用される
    # https://github.com/heartcombo/devise/blob/v4.8.0/lib/devise/models/authenticatable.rb#L289
    #
    # このメソッドではattributesとrequired_attributesを元に、Userインスタンスを取得している
    # しかし、Userインスタンスを取得した後は、attributesの値は後続の処理に引き継がれない
    # そのため、このメソッドをオーバーライドして、以下を行う
    # 　・superの実行前に、controller_value を取り出す
    # 　・superの実行後に、attr_accessor へセット
    controller_value = attributes.delete(:controller_value)

    user = super(required_attributes, attributes, error)
    user.tap do |u|
      u.controller_value = controller_value
    end
  end
end
