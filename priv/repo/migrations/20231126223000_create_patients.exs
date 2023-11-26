defmodule MedicalClinic.Repo.Migrations.CreatePatients do
  use Ecto.Migration

  def change do
    create table(:patients) do
      add :name, :text, null: false

      timestamps()
    end
  end
end
