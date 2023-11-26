alias MedicalClinic.Appointments.Patient
alias MedicalClinic.Appointments.Appointment
alias MedicalClinic.Repo

patients = [
  %{
    name: "Alice"
  },
  %{
    name: "Bob"
  },
  %{
    name: "Charlie"
  },
  %{
    name: "Daisy"
  },
  %{
    name: "Elliot"
  },
  %{
    name: "Fabian"
  }
]

now = DateTime.utc_now()

Enum.with_index(patients, fn patient, i ->
  patient_changeset = Patient.changeset(%Patient{}, patient)
  patient = Repo.insert!(patient_changeset)

  appt = %{
    scheduled_for: DateTime.add(now, 4 + i, :hour),
    patient_id: patient.id
  }

  appt_changeset = Appointment.changeset(%Appointment{}, appt)
  Repo.insert!(appt_changeset)
end)
