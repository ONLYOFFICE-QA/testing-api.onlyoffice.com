module TestingApiOnlyfficeCom
  # https://user-images.githubusercontent.com/18173785/37903128-7b1dcf28-30ff-11e8-828b-c3849e7a758c.png
  # http://api.onlyoffice.com/portals/basic http://api.teamlab.info/portals/basic
  class CommunityServerAPI
    include PageObject

    COMMUNITY_SERVER_API_LINKS = %i[
      authentication
      calendar
      capabilities
      community
      community_birthday
      community_blogs
      community_bookmarks
      community_events
      community_forums
      community_wiki
      crm
      crm_cases
      crm_common
      crm_contacts
      crm_files
      crm_history
      crm_invoices
      crm_opportunities
      crm_organisation
      crm_tags
      crm_tasks
      crm_user_fields
      crm_voip
      feed
      files
      files_file_creation
      files_file_operations
      files_files
      files_folders
      files_sharing
      files_third_party_integration
      files_uploads
      group
      mail
      mail_accounts
      mail_alerts
      mail_contacts
      mail_conversations
      mail_filters
      mail_folders
      mail_helpcenter
      mail_images
      mail_messages
      mail_settings
      mail_tags
      mailserver
      mailserver_addressdata
      mailserver_dnsrecords
      mailserver_domains
      mailserver_mailboxes
      mailserver_mailgroup
      mailserver_notifications
      mailserver_servers
      people
      people_reassign_user_data
      people_remove_user_data
      portal
      portal_backup
      portal_quota
      portal_users
      project
      project_comments
      project_contacts
      project_discussions
      project_files
      project_import
      project_milestones
      project_projects
      project_report
      project_tags
      project_tasks
      project_team
      project_template
      project_time
      settings
    ].freeze

    link(:identification, xpath: '//*[contains(@class, "treeheader")][text()="Portal api methods"]')

    link(:authentication, xpath: '//*[contains(@href, "authentication")]')
    link(:calendar, xpath: '//*[contains(@href, "calendar")]')
    link(:capabilities, xpath: '//*[contains(@href, "capabilities")]')
    link(:community, xpath: '//*[contains(@href, "community")]')
    link(:community_birthday, xpath: '//*[contains(@href, "community/birthday")]')
    link(:community_blogs, xpath: '//*[contains(@href, "community/blogs")]')
    link(:community_bookmarks, xpath: '//*[contains(@href, "community/bookmarks")]')
    link(:community_events, xpath: '//*[contains(@href, "community/events")]')
    link(:community_forums, xpath: '//*[contains(@href, "community/forums")]')
    link(:community_wiki, xpath: '//*[contains(@href, "community/wiki")]')
    link(:crm, xpath: '//*[contains(@href, "crm")]')
    link(:crm_cases, xpath: '//*[contains(@href, "crm/cases")]')
    link(:crm_common, xpath: '//*[contains(@href, "crm/common")]')
    link(:crm_contacts, xpath: '//*[contains(@href, "crm/contacts")]')
    link(:crm_files, xpath: '//*[contains(@href, "crm/files")]')
    link(:crm_history, xpath: '//*[contains(@href, "crm/history")]')
    link(:crm_invoices, xpath: '//*[contains(@href, "crm/invoices")]')
    link(:crm_opportunities, xpath: '//*[contains(@href, "crm/opportunities")]')
    link(:crm_organisation, xpath: '//*[contains(@href, "crm/organisation")]')
    link(:crm_tags, xpath: '//*[contains(@href, "crm/tags")]')
    link(:crm_tasks, xpath: '//*[contains(@href, "crm/tasks")]')
    link(:crm_user_fields, xpath: '//*[contains(@href, "crm/user%20fields")]')
    link(:crm_voip, xpath: '//*[contains(@href, "crm/voip")]')
    link(:feed, xpath: '//*[contains(@href, "feed")]')
    link(:files, xpath: '//*[contains(@href, "files")]')
    link(:files_file_creation, xpath: '//*[contains(@href, "files/file%20creation")]')
    link(:files_file_operations, xpath: '//*[contains(@href, "files/file%20operations")]')
    link(:files_files, xpath: '//*[contains(@href, "files/files")]')
    link(:files_folders, xpath: '//*[contains(@href, "files/folders")]')
    link(:files_sharing, xpath: '//*[contains(@href, "files/sharing")]')
    link(:files_third_party_integration, xpath: '//*[contains(@href, "files/third-party%20integration")]')
    link(:files_uploads, xpath: '//*[contains(@href, "files/uploads")]')
    link(:group, xpath: '//*[contains(@href, "group")]')
    link(:mail, xpath: '//*[contains(@href, "mail")]')
    link(:mail_accounts, xpath: '//*[contains(@href, "mail/accounts")]')
    link(:mail_alerts, xpath: '//*[contains(@href, "mail/alerts")]')
    link(:mail_contacts, xpath: '//*[contains(@href, "mail/contacts")]')
    link(:mail_conversations, xpath: '//*[contains(@href, "mail/conversations")]')
    link(:mail_filters, xpath: '//*[contains(@href, "mail/filters")]')
    link(:mail_folders, xpath: '//*[contains(@href, "mail/folders")]')
    link(:mail_helpcenter, xpath: '//*[contains(@href, "mail/helpcenter")]')
    link(:mail_images, xpath: '//*[contains(@href, "mail/images")]')
    link(:mail_messages, xpath: '//*[contains(@href, "mail/messages")]')
    link(:mail_settings, xpath: '//*[contains(@href, "mail/settings")]')
    link(:mail_tags, xpath: '//*[contains(@href, "mail/tags")]')
    link(:mailserver, xpath: '//*[contains(@href, "mailserver")]')
    link(:mailserver_addressdata, xpath: '//*[contains(@href, "mailserver/addressdata")]')
    link(:mailserver_dnsrecords, xpath: '//*[contains(@href, "mailserver/dnsrecords")]')
    link(:mailserver_domains, xpath: '//*[contains(@href, "mailserver/domains")]')
    link(:mailserver_mailboxes, xpath: '//*[contains(@href, "mailserver/mailboxes")]')
    link(:mailserver_mailgroup, xpath: '//*[contains(@href, "mailserver/mailgroup")]')
    link(:mailserver_notifications, xpath: '//*[contains(@href, "mailserver/notifications")]')
    link(:mailserver_servers, xpath: '//*[contains(@href, "mailserver/servers")]')
    link(:people, xpath: '//*[contains(@href, "people")]')
    link(:people_reassign_user_data, xpath: '//*[contains(@href, "people/reassign%20user%20data")]')
    link(:people_remove_user_data, xpath: '//*[contains(@href, "people/remove%20user%20data")]')
    link(:portal, xpath: '//*[contains(@href, "portal")]')
    link(:portal_backup, xpath: '//*[contains(@href, "portal/backup")]')
    link(:portal_quota, xpath: '//*[contains(@href, "portal/quota")]')
    link(:portal_users, xpath: '//*[contains(@href, "portal/users")]')
    link(:project, xpath: '//*[contains(@href, "project")]')
    link(:project_comments, xpath: '//*[contains(@href, "project/comments")]')
    link(:project_contacts, xpath: '//*[contains(@href, "project/contacts")]')
    link(:project_discussions, xpath: '//*[contains(@href, "project/discussions")]')
    link(:project_files, xpath: '//*[contains(@href, "project/files")]')
    link(:project_import, xpath: '//*[contains(@href, "project/import")]')
    link(:project_milestones, xpath: '//*[contains(@href, "project/milestones")]')
    link(:project_projects, xpath: '//*[contains(@href, "project/projects")]')
    link(:project_report, xpath: '//*[contains(@href, "project/report")]')
    link(:project_tags, xpath: '//*[contains(@href, "project/tags")]')
    link(:project_tasks, xpath: '//*[contains(@href, "project/tasks")]')
    link(:project_team, xpath: '//*[contains(@href, "project/team")]')
    link(:project_template, xpath: '//*[contains(@href, "project/template")]')
    link(:project_time, xpath: '//*[contains(@href, "project/time")]')
    link(:settings, xpath: '//*[contains(@href, "settings")]')

    # controls
    elements(:expandable_hitarea, xpath: '//*[contains(@class, "hitarea expandable-hitarea")]')

    def initialize(instance)
      @instance = instance
      super(@instance.webdriver.driver)
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { identification_element.visible? }
    end

    def expand_every_expandable_area
      return if expandable_hitarea_elements.size.zero?

      expandable_hitarea_elements.each do |element|
        element.click
        sleep 1
      end
      expand_every_expandable_area unless expandable_hitarea_elements.size.zero?
    end

    def check_community_server_api_links
      checked = {}
      COMMUNITY_SERVER_API_LINKS.each do |link|
        checked[link] = send("#{link}_element").visible?
      end
      checked
    end

    def community_server_links_ok?
      checked = check_community_server_api_links
      failed = checked.find_all { |_key, value| value == false }
      [failed.empty?, failed]
    end
  end
end
