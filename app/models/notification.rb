class Notification < ApplicationRecord
  belongs_to :user

  #0: Llego un nuevo procedimiento (mezclar con #3)
  #1: Fiscal cerró un procedimiento (listo)
  #2: Fiscal solicito más datos respecto a un procedimiento (pendiente)
  #3: Carabinero respondió con más datos respecto a un procedimiento (mezclar con #0)
  #4: Has recibido un mensaje (listo)

  enum notification_type: {new_procedure: 0, procedure_closed: 1, procedure_requiring_info: 2, procedure_info_updated: 3, new_message: 4}

  def notification_type
    super.to_s.humanize
  end
end
