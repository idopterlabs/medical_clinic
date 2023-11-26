defmodule MedicalClinic.Appointments.Appointment do
  use Ecto.Schema
  import Ecto.Changeset

  alias MedicalClinic.Appointments.Patient

  schema "appointments" do
    field :scheduled_for, :naive_datetime
    field :is_checked_in, :boolean
    belongs_to :patient, Patient

    timestamps()
  end

  @doc false
  def changeset(appointment, attrs) do
    appointment
    |> cast(attrs, [:patient_id, :scheduled_for])
    |> validate_required([:patient_id, :scheduled_for])
  end

  def check_in_changeset(appointment, attrs) do
    appointment
    |> cast(attrs, [:is_checked_in])
    |> validate_required([:is_checked_in])
  end
end
