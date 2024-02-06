defmodule MedicalClinicWeb.AppointmentsLive do
  use MedicalClinicWeb, :live_view

  alias MedicalClinic.Appointments
  alias MedicalClinicWeb.AppointmentEntry

  @topic "check-in"
  @pub_sub MedicalClinic.PubSub

  def mount(_params, _session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(@pub_sub, @topic)
    end

    socket = assign(socket, appointments: Appointments.list_appointments())
    {:ok, socket}
  end

  def handle_event("check-in", %{"id" => appointment_id}, socket) do
    Appointments.toggle_check_in!(appointment_id)

    Phoenix.PubSub.broadcast(@pub_sub, @topic, :update)

    {:noreply, socket}
  end

  def handle_info(:update, socket) do
    socket =
      assign(
        socket,
        :appointments,
        Appointments.list_appointments()
      )

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div :for={appointment <- @appointments}>
      <.live_component module={AppointmentEntry} id={appointment.id} appointment={appointment} />
    </div>
    """
  end
end
