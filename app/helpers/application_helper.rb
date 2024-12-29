module ApplicationHelper
    def service_name
        title = "SenMall"
        title
    end
    def page_title
        title = @page_title + " - " + service_name if @page_title
        title
    end
    def currency
        currency = "¥"
        currency
    end
    def menu_link_to(text, path, options = {})
        content_tag :li do
            condition = options[:method] || !current_page?(path)
            link_to_if(condition, text, path, options) do
                content_tag(:span, text)
            end
        end
    end
end
