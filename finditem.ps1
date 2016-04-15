# Usage:
# Recursive search
#  Find-Item "foo" -Recurse
# Non recursive search
#  Find-Item "foo"
Function Find-Item($str, [switch]$Recurse) { 
	if ($Recurse) {
		$result = Get-ChildItem -Recurse -ErrorAction SilentlyContinue -ErrorVariable err
	} else {
		$result = Get-ChildItem -ErrorAction SilentlyContinue -ErrorVariable err
	}

	foreach ($errorRecord in $err) {
		if ($errorRecord.Exception -is [System.IO.PathTooLongException]) {
			Write-Warning "Some paths were ignored due to too long paths."
			break
		}
	}
	
	$result `
		| ? { $_.Name.Contains($str) } `
		| % { $_.DirectoryName + "\" + $_.Name }
}
