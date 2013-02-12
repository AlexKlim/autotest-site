module ApplicationHelper

  def tab_menu
    items = [ 
      {url: root_path, text: 'Tests / Reports', active: params[:controller] == 'pages'},
      {url: edit_timetables_path, text: 'TimeTable', active: params[:controller] == 'timetables'},
    ]
  end
  
end
