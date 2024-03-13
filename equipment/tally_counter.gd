class_name TallyCounter
extends RefCounted

var current_count:int = 0


func count():
	current_count += 1
	
func reset():
	current_count = 0
