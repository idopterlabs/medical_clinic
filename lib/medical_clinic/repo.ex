defmodule MedicalClinic.Repo do
  use Ecto.Repo,
    otp_app: :medical_clinic,
    adapter: Ecto.Adapters.Postgres
end
