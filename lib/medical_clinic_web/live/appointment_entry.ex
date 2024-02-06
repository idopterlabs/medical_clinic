defmodule MedicalClinicWeb.AppointmentEntry do
  use MedicalClinicWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class={[
      "rounded w-4/5 mx-auto my-2 p-10 h-24 flex items-center place-content-between bg-blue-300",
      if(@appointment.is_checked_in, do: "bg-green-200")
    ]}>
      <p class="text-teal-900 font-light text-3xl"><%= @appointment.patient.name %></p>
      <p class="text-blue-900 text-sm">
        <div class="flex container text-xs flex-col text-right">
          <div :if={@appointment.is_checked_in} class="p-2 font-bold text-xl">
            Checked-in!
          </div>
          <div :if={!@appointment.is_checked_in} class="p-2">
            <button
              class="bg-blue-600 hover:bg-blue-700 text-white text-lg font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline transform transition-colors duration-300"
              data-confirm="Are you sure?"
              phx-click="check-in"
              phx-value-id={@appointment.id}
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
