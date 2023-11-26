defmodule MedicalClinic.Appointments do
  @doc """
  Context module for Appointment related operations
  """

  import Ecto.Query

  alias MedicalClinic.Appointments.Appointment
  alias MedicalClinic.Repo

  def list_appointments do
    from(Appointment,
      order_by: [desc: :is_checked_in]
    )
    |> Repo.all()
    |> Repo.preload(:patient)
  end
end
