require 'redmine'
require 'casclient'
require 'casclient/frameworks/rails/filter'
require 'socket'
require 'timeout'
require 'redmine_cas'

Redmine::Plugin.register :redmine_cas do
    name        "CAS Authentication"
    author      'Mirek Rusin'
    description "CAS single sign-on service authentication support. After configuring plugin login/logout actions will be delegated to CAS server."
    version     '0.0.3'
  
    menu        :account_menu,
                :login_without_cas,
                {
                  :controller => 'account',
                  :action     => 'login_without_cas'
                },
                :caption => :login_without_cas,
                :after   => :login,
                :if      => Proc.new { RedmineCas.ready? && RedmineCas.get_setting(:login_without_cas) && !User.current.logged? }
  
    settings :default => {
                            :enabled                         => false,
                            :cas_base_url                    => 'https://localhost',
                            :login_without_cas               => false,
                            :auto_create_users               => false,
                            :auto_update_attributes_on_login => false,
                            :cas_logout => true
                          }, 
             :partial => 'settings/settings'
end