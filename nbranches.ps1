$longestBranchName = 0;
$activeBranch = "";

Write-Host "`n`n`tActive branches:`n`n"

hg branch | % { $activeBranch = $_ }

hg branches | % {
	$splits = $_.Split(' ');
	$splits = $splits | ? {$_}
	$branch = $splits[0];
	if ($branch.Length -gt $longestBranchName) {
		$longestBranchName = $branch.Length;
	}
}
$longestBranchName = $longestBranchName + 4;
hg branches | % {
	$splits = $_.Split(' ');
	$splits = $splits | ? {$_}
	$branch = $splits[0];
	$changeset = $splits[1];
	$active = "";
	if ($splits.Count -gt 2) {
		$active = $splits[2];
	}

	if ($branch -eq $activeBranch) {
		Write-Host ("{0, $longestBranchName} " -f $branch) -f Green -NoNewline
	} else {
		Write-Host ("{0, $longestBranchName} " -f $branch) -NoNewline
	}
	Write-Host ": " -NoNewline
	Write-Host $changeset -f Yellow -NoNewline
	Write-Host " $active"
}

Write-Host "`n`n"
