module ApplicationHelper
  def validation_params(data, required_params, optional_params)
    error = ""
    if !required_params.nil?
      required_params.each do |key, expected_type|

        unless data.key?(key)
          error = error + "#{key.capitalize}. Is missing,"
        end
  
        unless data.key?(key) && data[key].present? && data[key].is_a?(expected_type)
          error = error + "#{key.capitalize} Invalid Type Data. Expected #{expected_type} got #{data[key].class},"
        end
  
        if data[key].is_a?(Integer)
          unless data[key] > 0
            error = error + "#{key.capitalize} Must be grater then 0,"
          end
        end
      end
  
      unless error.length == 0
        raise ArgumentError, error
      end
    end

    if !optional_params.nil?
      optional_params.each do |key, expected_type|  
        unless (data.key?(key) && data[key].present? && data[key].is_a?(expected_type)) || data[key].blank?
          error = error + "#{key.capitalize} Invalid Type Data. Expected #{expected_type} got #{data[key].class},"
        end
  
        if data[key].is_a?(Integer)
          unless data[key] > 0
            error = error + "#{key.capitalize} Must be grater then 0,"
          end
        end
      end
  
      unless error.length == 0
        raise ArgumentError, error
      end
    end
  end
end