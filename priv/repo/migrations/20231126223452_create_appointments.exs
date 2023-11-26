defmodule MedicalClinic.Repo.Migrations.CreateAppointments do
  use Ecto.Migration

  def change do
    create table(:appointments) do
      add :scheduled_for, :naive_datetime, null: false
      add :patient_id, references(:patients, on_delete: :restrict)
      add :is_checked_in, :boolean, default: false

      timestamps()
    end
  end
end
