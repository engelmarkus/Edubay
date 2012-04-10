# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  # Specify a custom renderer if needed.
  # The default renderer is SimpleNavigation::Renderer::List which renders HTML lists.
  # The renderer can also be specified as option in the render_navigation call.
  # navigation.renderer = Your::Custom::Renderer

  # Specify the class that will be applied to active navigation items. Defaults to 'selected'
  # navigation.selected_class = 'your_selected_class'

  # Specify the class that will be applied to the current leaf of
  # active navigation items. Defaults to 'simple-navigation-active-leaf'
  # navigation.active_leaf_class = 'your_active_leaf_class'

  # Item keys are normally added to list items as id.
  # This setting turns that off
  # navigation.autogenerate_item_ids = false

  # You can override the default logic that is used to autogenerate the item ids.
  # To do this, define a Proc which takes the key of the current item as argument.
  # The example below would add a prefix to each key.
  # navigation.id_generator = Proc.new {|key| "my-prefix-#{key}"}

  # If you need to add custom html around item names, you can define a proc that will be called with the name you pass in to the navigation.
  # The example below shows how to wrap items spans.
  # navigation.name_generator = Proc.new {|name| "<span>#{name}</span>"}

  # The auto highlight feature is turned on by default.
  # This turns it off globally (for the whole plugin)
  # navigation.auto_highlight = false

  # Define the primary navigation
  navigation.items do |primary|
    # Add an item to the primary navigation. The following params apply:
    # key - a symbol which uniquely defines your navigation item in the scope of the primary_navigation
    # name - will be displayed in the rendered navigation. This can also be a call to your I18n-framework.
    # url - the address that the generated item links to. You can also use url_helpers (named routes, restful routes helper, url_for etc.)
    # options - can be used to specify attributes that will be included in the rendered navigation item (e.g. id, class etc.)
    #           some special options that can be set:
    #           :if - Specifies a proc to call to determine if the item should
    #                 be rendered (e.g. <tt>:if => Proc.new { current_user.admin? }</tt>). The
    #                 proc should evaluate to a true or false value and is evaluated in the context of the view.
    #           :unless - Specifies a proc to call to determine if the item should not
    #                     be rendered (e.g. <tt>:unless => Proc.new { current_user.admin? }</tt>). The
    #                     proc should evaluate to a true or false value and is evaluated in the context of the view.
    #           :method - Specifies the http-method for the generated link - default is :get.
    #           :highlights_on - if autohighlighting is turned off and/or you want to explicitly specify
    #                            when the item should be highlighted, you can set a regexp which is matched
    #                            against the current URI.  You may also use a proc, or the symbol <tt>:subpath</tt>. 
    #
    #primary.item :key_1, 'name', url, options
    
    # Add an item which has a sub navigation (same params, but with block)
    #primary.item :key_2, 'name', url, options do |sub_nav|
      # Add an item to the sub navigation (same params again)
      #sub_nav.item :key_2_1, 'name', url, options
    #end

    primary.item :home, 'Home', url_for(action: 'index', controller: 'home'), hightlights_on: Regexp.new('/home') do |sub_nav|
      sub_nav.item :home_intro, t('home.intro'), url_for(action: 'intro', controller: 'home')
      
      sub_nav.dom_class = "nav_depth02"
    end
    
    primary.item :terms, t('navigation.terms'), url_for(action: 'index', controller: 'terms'), :highlights_on => Regexp.new('/terms') do |sub_nav|
      sub_nav.item :terms_list, t('navigation.list'), url_for(action: 'index', controller: 'terms')
      
      if admin? then
        sub_nav.item :terms_new, t('navigation.new'), url_for(action: 'new', controller: 'terms')
      end
      
      sub_nav.dom_class = 'nav_depth02'
    end
    
    primary.item :lecturers, t('navigation.lecturers'), url_for(action: 'index', controller: 'lecturers'), :highlights_on => Regexp.new('/lecturers') do |sub_nav|
      sub_nav.item :lecturers_list, t('navigation.list'), url_for(action: 'index', controller: 'lecturers')
      
      if admin? then
        sub_nav.item :lecturers_new, t('navigation.new'), url_for(action: 'new', controller: 'lecturers')
      end
      
      sub_nav.dom_class = 'nav_depth02'
    end
    
    primary.item :courses, t('navigation.courses'), url_for(action: 'index', controller: 'courses'), :highlights_on => Regexp.new('/courses') do |sub_nav|
      sub_nav.item :courses_list, t('navigation.list'), url_for(action: 'index', controller: 'courses')
      
      if admin? then
        sub_nav.item :courses_new, t('navigation.new'), url_for(action: 'new', controller: 'courses')
      end
      
      sub_nav.dom_class = 'nav_depth02'
    end
    
    primary.item :documents, t('navigation.documents'), url_for(action: 'index', controller: 'documents'), :highlights_on => Regexp.new('/documents') do |sub_nav|
      sub_nav.item :documents_list, t('navigation.list'), url_for(action: 'index', controller: 'documents')
      
      if logged_in? then
        sub_nav.item :documents_new, t('navigation.new'), url_for(action: 'new', controller: 'documents')
      end
      
      sub_nav.dom_class = 'nav_depth02'
    end

    #primary.item :dev_types, t('navigation.dev_types'), url_for(action: 'index', controller: 'dev_types'), :highlights_on => Regexp.new('/dev_types') do |sub_nav|
    #  sub_nav.item :dev_types_list, t('navigation.list'), url_for(action: 'index', controller: 'dev_types')
    #  sub_nav.item :dev_types_new, t('navigation.new'), url_for(action: 'new', controller: 'dev_types')
    #  
    #  sub_nav.dom_class = 'nav_depth02'
    #end
    
    #primary.item :devices, t('navigation.devices'), url_for(action: 'index', controller: 'devices'), :highlights_on => Regexp.new('/devices') do |sub_nav|
    #  sub_nav.item :devices_list, t('navigation.list'), url_for(action: 'index', controller: 'devices')
    #  sub_nav.item :devices_new, t('navigation.new'), url_for(action: 'new', controller: 'devices')
    #  
    #  sub_nav.dom_class = 'nav_depth02'
    #end

    #primary.item :reservations, t('navigation.reservations'), url_for(action: 'index', controller: 'reservations'), :highlights_on => Regexp.new('/reservations') do |sub_nav|
    #  sub_nav.item :reservations_list, t('navigation.list'), url_for(action: 'index', controller: 'reservations')
    #  sub_nav.item :reservations_new, t('navigation.new'), url_for(action: 'new', controller: 'reservations')
    #  
    #  sub_nav.dom_class = 'nav_depth02'
    #end
    
    # You can also specify a condition-proc that needs to be fullfilled to display an item.
    # Conditions are part of the options. They are evaluated in the context of the views,
    # thus you can use all the methods and vars you have available in the views.
    #primary.item :key_3, 'Admin', url, :class => 'special', :if => Proc.new { current_user.admin? }
    #primary.item :key_4, 'Account', url, :unless => Proc.new { logged_in? }

    # you can also specify a css id or class to attach to this particular level
    # works for all levels of the menu
    # primary.dom_id = 'menu-id'
    # primary.dom_class = 'menu-class'
    primary.dom_id = 'navigationlist'

    # You can turn off auto highlighting for a specific level
    # primary.auto_highlight = false

  end
end
