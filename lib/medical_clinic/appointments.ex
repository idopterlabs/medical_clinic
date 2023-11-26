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

  def toggle_checkl_in!(appointment_id) do
    appt = Repo.get(Appointment, appointment_id)

    changeset =
      Appointment.check_in_changeset(appt, %{
        is_checked_in: !appt.is_checked_in
      })

    Repo.update!(changeset)
  end
end
