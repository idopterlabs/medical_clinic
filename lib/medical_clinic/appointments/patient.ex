defmodule MedicalClinic.Appointments.Patient do
  use Ecto.Schema
  import Ecto.Changeset

  schema "patients" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(patient, attrs) do
    patient
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
