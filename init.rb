require_dependency 'kanbantool/hooks/view_issues_form_details_bottom_hook'
require_dependency 'kanbantool/hooks/controller_issues_new_after_save_hook'

Redmine::Plugin.register :kanbantool do
    name 'Kanban Tool'
    author 'Ewald Kleefstra <kleefstra@gyselroth.com>'
    description 'This plugin connects Kanban Tool with Redmine by letting users choose to automatically add an entry into Kanban Tool when creating a new issue. Go to plugin config to set up'
    version '1.0.1'
    url 'http://www.gyselroth.com'
    author_url 'http://www.gyselroth.com'
    settings :default => {}, :partial => 'settings/kanbantool_settings'
    project_module :kanbantool_module do
        permission :use_kanbantool, {}
    end
end
