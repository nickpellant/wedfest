class ApplicationPolicy
  attr_reader :invite, :record

  def initialize(invite, record)
    @invite = invite
    @record = record
  end
end
