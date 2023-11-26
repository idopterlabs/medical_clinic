defmodule MedicalClinicWeb.QueueLive do
  use MedicalClinicWeb, :live_view

  alias MedicalClinic.Appointments

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
    Appointments.toggle_checkl_in!(appointment_id)

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
    <div
      :for={appointment <- assigns.appointments}
      class={[
        "rounded w-4/5 mx-auto my-2 p-10 h-24 flex items-center place-content-between bg-blue-300",
        if(appointment.is_checked_in, do: "bg-green-200")
      ]}
    >
      <p class="text-teal-900 font-light text-3xl"><%= appointment.patient.name %></p>
      <p class="text-blue-900 text-sm">
        <div class="flex container text-xs flex-col text-right">
          <div :if={appointment.is_checked_in} class="p-2 font-bold text-xl">
            Checked-in!
          </div>
          <div :if={!appointment.is_checked_in} class="p-2">
            <button
              class="bg-blue-600 hover:bg-blue-700 text-white text-lg font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline transform transition-colors duration-300"
              phx-value-id={appointment.id}
              data-confirm="Are you sure ?"
              phx-click="check-in"
            >
              Check-in
            </button>
          </div>
        </div>
      </p>
    </div>
    """
  end
end
