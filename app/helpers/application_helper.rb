# frozen_string_literal: true

module ApplicationHelper
  def alert_class(flash_type)
    {
      alert: "alert-warning",
      error: "alert-danger",
      notice: "alert-info",
      success: "alert-success"
    }[flash_type.to_sym] || "alert-#{flash_type}"
  end
end
