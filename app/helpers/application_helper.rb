module ApplicationHelper
  # def flash_class(level)
  #   case level
  #   when :notice then "alert alert-info"
  #   when :success then "alert alert-success"
  #   when :error then "alert alert-error"
  #   when :alert then "alert alert-error"
  #   end
  # end

  def flash_class(level)
    bootstrap_alert_class = {
      "success" => "alert-success",
      "error" => "alert-error",
      "notice" => "alert-info",
      "alert" => "alert-danger",
      "warn" =>  "alert-warning"
    }
    bootstrap_alert_class[level]
  end
end
