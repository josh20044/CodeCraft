extends Control

var chapter1 = preload("res://Chapters(F2)/FIRSTCHAPTERCONTENT.tscn")
var chapter2 = preload("res://Chapters(F2)/SECONDCHAPTERCONTENT.tscn")
var current_chapter = 0
var chapters = [
	{
		"chapter": "0",
		"title": "1",
		"node": preload("res://Chapters(F2)/FIRSTCHAPTERCONTENT.tscn")
	},
	{
		"chapter": "1",
		"title": "1",
		"node": preload("res://Chapters(F2)/SECONDCHAPTERCONTENT.tscn")
	},
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Assesstment/ChapterLessonList.add_child(chapter1.instantiate())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_x_btn_pressed() -> void:
	UiSignals.chapter_close.emit()

func _on_button_2_pressed() -> void:
	UiSignals.chapter_close.emit()
	UiSignals.info_open.emit()


func _on_next_pressed() -> void:
	current_chapter += 1
	current_chapter = clamp(current_chapter, 0, 1)
	set_chapter(current_chapter)


func _on_prev_pressed() -> void:
	current_chapter -= 1
	current_chapter = clamp(current_chapter, 0, 1)
	set_chapter(current_chapter)

func set_chapter(index: int):
	$Assesstment/Chapter.text = "CHAPTER - " + chapters[index]["chapter"]
	$Assesstment/Title.text = "Title - " + chapters[index]["title"]
	for i in $Assesstment/ChapterLessonList.get_children():
		i.queue_free()
	$Assesstment/ChapterLessonList.add_child(chapters[index]["node"].instantiate())
