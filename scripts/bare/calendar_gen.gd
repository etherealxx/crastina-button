extends Control

var cal: Calendar = Calendar.new()

var months_formatted: Array[String]
var weekdays_formatted: Array[String]
var selected_date: Calendar.Date
var selected_date_label: Label

# Helper class for generating date labels.
#class CalendarLabel:
	#extends Label
	#
	#var clickable: bool = false
	#
	#signal pressed()
	#
	#
	#func _init(p_text: String, p_clickable: bool = false):
		#text = p_text
		#horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		#label_settings = LabelSettings.new()
		#set_font_size()
		#if p_clickable:
			#clickable = p_clickable
			#mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
			#mouse_filter = Control.MOUSE_FILTER_STOP
	#
	#
	#func _gui_input(event: InputEvent) -> void:
		#if event is InputEventMouseButton and event.pressed:
			#if clickable:
				#pressed.emit()
	#
	#
	#func set_font_size(font_size: int = 12):
		#label_settings.font_size = font_size

class CalendarLabel:
	extends Button
	
	func _init(p_text: String, p_clickable: bool = false):
		text = p_text
		#horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		#label_settings = LabelSettings.new()
		set_font_size()
		if p_clickable:
			#clickable = p_clickable
			#mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
			#mouse_filter = Control.MOUSE_FILTER_STOP
			pass
	
	
	#func _gui_input(event: InputEvent) -> void:
		#if event is InputEventMouseButton and event.pressed:
			#if clickable:
				#pressed.emit()
	
	func set_font_size(font_size: int = 12):
		#label_settings.font_size = font_size
		set("theme_override_font_sizes/font_size", font_size)

func _add_month_grid_container(p_month: int):
	var month_container = VBoxContainer.new()
	month_container.set("theme_override_constants/separation", 10)
	
	var month_title = CalendarLabel.new(months_formatted[p_month - 1])
	#month_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	#month_title.label_settings.font_color = Color("#ffffff")
	month_title.set("theme_override_colors/font_color", Color("#ffffff"))
	month_container.add_child(month_title)
	
	var month_grid = GridContainer.new()
	month_grid.columns = 7 # 8 if show_weeks else 7
	month_grid.set("theme_override_constants/h_separation", 14)
	month_grid.set("theme_override_constants/v_separation", 6)
	month_container.add_child(month_grid)
	$MonthCalCont.add_child(month_container) # %YearCalendar.add_child(month_container)
	return month_grid

func _ready():
	cal.set_first_weekday(Time.WEEKDAY_MONDAY)
	cal.week_number_system = Calendar.WeekNumberSystem.WEEK_NUMBER_FOUR_DAY
	
	selected_date = Calendar.Date.today()
	weekdays_formatted = cal.get_weekdays_formatted(Calendar.WeekdayFormat.WEEKDAY_FORMAT_SHORT)
	months_formatted = cal.get_months_formatted(Calendar.MonthFormat.MONTH_FORMAT_FULL)
	
	var todays_date := Calendar.Date.today()
	var month_calendar = cal.get_calendar_month(todays_date.year, todays_date.month, true)
	var month_container = _add_month_grid_container(1)
	for weekday in weekdays_formatted:
		var weekday_label = CalendarLabel.new(weekday)
		month_container.add_child(weekday_label)
	for week in month_calendar:
		for date in week:
			var date_label = CalendarLabel.new(str(date.day), true)
			if date.month == todays_date.month: #@TODO uncomment later for not current months
				if date.is_equal(todays_date):
					#date_label.label_settings.font_color = Color("#70bafa")
					date_label.set("theme_override_colors/font_color", Color("#70bafa"))
				else:
					#date_label.label_settings.font_color = Color("#cdced2")
					date_label.set("theme_override_colors/font_color", Color("#70bafa"))
			else:
				#date_label.label_settings.font_color = Color("#414853")
				date_label.set("theme_override_colors/font_color", Color("#cdced2"))
			
			date_label.pressed.connect(_on_date_pressed.bind(date, date_label))
			month_container.add_child(date_label)
			
			if date.is_equal(selected_date):
				#set_selected_state(date_label)
				pass

func _on_date_pressed(date: Calendar.Date, date_label: Label):
	set_selected_state(date_label)
	#set_date_label(date)
	selected_date = date
	
func set_date_label(date: Calendar.Date):
	%DateLabel.text = cal.get_date_formatted(date.year, date.month, date.day, "%A, %-d %B")
	
func set_selected_state(date_label: Label):
	if selected_date_label and selected_date_label.get_child_count() > 0:
		selected_date_label.get_child(0).queue_free()
	var selected_rect: ColorRect = ColorRect.new()
	selected_rect.size = Vector2(20, 20)
	selected_rect.position += Vector2(-4, -2)
	selected_rect.color = Color("#414853")
	selected_rect.show_behind_parent = true
	date_label.add_child(selected_rect)
	selected_date_label = date_label
