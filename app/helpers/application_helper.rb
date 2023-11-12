module ApplicationHelper
  def validation_params(params, required_params, optional_params = {})
    error = ""
    required_params.each do |key, expected_type|

      unless params.key?(key)
        error = error + "#{key.capitalize}. Is missing,"
      end

      unless params.key?(key) && params[key].present? && params[key].is_a?(expected_type)
        error = error + "#{key.capitalize} Invalid Type Data. Expected #{expected_type} got #{params[key].class},"
      end

      if params[key].is_a?(Integer)
        unless params[key] > 0
          error = error + "#{key.capitalize} Must be grater then 0,"
        end
      end
    end

    unless error.length == 0
      raise ArgumentError, error
    end
  end
end