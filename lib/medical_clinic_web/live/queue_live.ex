defmodule MedicalClinicWeb.QueueLive do
  use MedicalClinicWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, appointments: appointment_fixtures())
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div
      :for={appointment <- assigns.appointments}
      class={[
        "rounded w-4/5 mx-auto my-2 p-10 h-24 flex items-center place-content-between bg-blue-300"
      ]}
    >
      <p class="text-teal-900 font-light text-3xl"><%= appointment.patient.name %></p>
      <p class="text-blue-900 text-sm">
        <div class="flex container text-xs flex-col text-right">
          <div :if={appointment.is_checked_in}>Checked-in!</div>
          <div :if={!appointment.is_checked_in} class="p-2">
            <button
              class="bg-blue-600 hover:bg-blue-700 text-white text-lg font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline transform transition-colors duration-300"
              phx-value-id={appointment.id}
              data-confirm="Are you sure ?"
            >
              Check-in
            </button>
          </div>
        </div>
      </p>
    </div>
    """
  end

  defp appointment_fixtures do
    [
      %{
        id: 1,
        patient: %{name: "Alice"},
        is_checked_in: false
      },
      %{
        id: 2,
        patient: %{name: "Bob"},
        is_checked_in: false
      },
      %{
        id: 3,
        patient: %{name: "Charlie"},
        is_checked_in: false
      },
      %{
        id: 4,
        patient: %{name: "Daisy"},
        is_checked_in: false
      }
    ]
  end
end