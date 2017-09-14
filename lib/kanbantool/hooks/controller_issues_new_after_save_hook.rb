module AddToKanban
    class Hooks < Redmine::Hook::ViewListener
        def controller_issues_new_after_save(context={})
            kanban_project = context[:params][:kanban_project]
            kanban_stage = context[:params][:kanban_stage]
            kanban_swimlane = context[:params][:kanban_swimlane]
            kanban_subject = context[:params][:kanban_subject]
            go_further = false;
            if !Setting.plugin_kanbantool['kanban_board_role'].nil? && Setting.plugin_kanbantool['kanban_board_role'] != ""
                kanban_board_role = JSON.parse(Setting.plugin_kanbantool['kanban_board_role'])
                roles_for_project = User.current.roles_for_project(context[:issue].project)
                if !roles_for_project.nil?
                    roles_for_project.each do |role|
                        if !kanban_board_role[kanban_project].nil?
                            kanban_board_role[kanban_project].each do |board|
                                if role["id"].to_s == board.to_s
                                    go_further = true
                                    break;
                                end
                            end
                        end
                        break if go_further
                    end
                end
            end
            if !Setting.plugin_kanbantool['kanban_hide'].nil? && Setting.plugin_kanbantool['kanban_hide'] != ""
                kanban_hide = Setting.plugin_kanbantool['kanban_hide'].split(',')
                kanban_hide.each do |hide_id|
                    if kanban_stage == hide_id
                        go_further = false;
                    end
                end
            end
            if !Setting.plugin_kanbantool['kanban_hide_lanes'].nil? && Setting.plugin_kanbantool['kanban_hide_lanes'] != ""
                kanban_hide_lanes = Setting.plugin_kanbantool['kanban_hide_lanes'].split(',')
                kanban_hide_lanes.each do |hide_id|
                    if kanban_swimlane == hide_id
                        go_further = false;
                    end 
                end 
            end
            custom_field_id = ""
            if !Setting.plugin_kanbantool['kanban_custom_field_id'].nil?
                custom_field_id = Setting.plugin_kanbantool['kanban_custom_field_id']
            end
            if kanban_project != "null" && go_further && User.current.allowed_to?(:use_kanbantool, context[:issue].project)
                if !Setting.plugin_kanbantool['kanban_hide_fields'].nil? && Setting.plugin_kanbantool['kanban_hide_fields'] != ""
                    kanban_hide_fields = Setting.plugin_kanbantool['kanban_hide_fields'].split(',')
                end
                if !kanban_hide_fields.nil?
                    if kanban_hide_fields.include? "kanban_subject"
                        kanban_subject = ""
                    end
                    if kanban_hide_fields.include? "kanban_stage"
                        kanban_stage = ""
                    end
                    if kanban_hide_fields.include? "kanban_swimlane"
                        kanban_swimlane = ""
                    end
                    if kanban_hide_fields.include? "kanban_description"
                        kanban_description = ""
                    end
                end
                if kanban_subject == "" || kanban_subject.nil?
                    kanban_subject = context[:issue].subject
                end
                kanban_description = context[:params][:kanban_description]
                if context[:params][:kanban_description_same]
                    kanban_description = context[:issue].description
                end
                id = context[:issue].id
                redmine_url = context[:params][:redmine_url]
                redmine_url = redmine_url + "issues/" + id.to_s
                kanban = {
                    "workflow_stage_id" => kanban_stage,
                    "swimlane_id" => kanban_swimlane,
                    "name" => kanban_subject,
                    "description" => kanban_description,
                    "external_link" => redmine_url,
                    "custom_field_"+custom_field_id => id.to_s,
                    "api_token" => Setting.plugin_kanbantool['kanban_token']
                }
                params = ""
                kanban.each do |(index,data)|
                    if data !="" && !data.nil?
                        params += "&"+index+"="+data.to_s.strip
                    end
                end
                params[0] = ""
                begin
                    require 'net/http'
                    require 'uri'
                    require 'json'
                    uri = URI.parse("https://#{Setting.plugin_kanbantool['kanban_domain']}.kanbantool.com/api/v1/boards/#{kanban_project}/tasks.xml")
                    https = Net::HTTP.new(uri.host, uri.port)
                    https.use_ssl = true
                    response = https.post(uri.path,params)
                rescue Exception => e
                    Rails.logger.info "Something went wrong while making HTTP request:" + e.inspect
                end
            end
        end 
    end
end
