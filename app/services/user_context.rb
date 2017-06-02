class UserContext
  attr_reader :usuario, :session

  def initialize(usuario, session)
    @usuario = usuario
    @session = session
  end
end
