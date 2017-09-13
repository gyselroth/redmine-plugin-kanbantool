module AddKanbanToForm
    module Hooks
        class ViewIssuesFormDetailsBottomHook < Redmine::Hook::ViewListener
            render_on(:view_issues_form_details_bottom, :partial => 'hooks/add_kanban_to_form', :layout => false)
        end
    end
end
