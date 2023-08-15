module StudentHelper
    def sortable(column, title = nil)
        title ||= column.titleize
        direction = (column == params[:sort] && params[:direction] == "desc") ? "asc" : "desc"
        link_to title, { sort: column, direction: direction, filter: params[:filter] }, { class: "sortable" }
      end
end
