tell application "Finder"
	set this_folder to insertion location as text
	if (count of (get selection)) is equal to 1 then
		set file_alias to the selection as alias
		set default_name to name of file_alias
	else
		set default_name to "New Text File"
	end if
end tell

set new_file to text returned of (display dialog "Folder: " & POSIX path of this_folder & "

Enter file name (.txt will be added later)" default answer default_name)

set the_filename to new_file & ".txt"
set the_pathname to this_folder & the_filename

tell application "Finder"
	if exists file the_pathname then
		set e_exist to true
	else
		set e_exist to false
	end if
end tell

if e_exist is true then
	display alert "File already exists:
" & the_filename
else
	tell application "Finder"
		try
			set new_file to make new file at insertion location as alias with properties {name:the_filename}
			set extension hidden of new_file to false
			select new_file
		on error errMsg
			display dialog {errMsg}
		end try
	end tell
end if
