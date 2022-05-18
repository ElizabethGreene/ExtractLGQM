#ExtractLQMs.ps1
#Copyright 20220518 Elizabeth Greene <Elizabeth.a.Greene@gmail.com>
#I scan a folder for LG QuickMemo+ .lqm files and extract the text, HTML, and thumbnails to an output folder
#Version 0.1 - This is PRE-ALPHA quality code and should not be used in production


# Update this with where you want the output files to go
$outputFolder = 'c:\users\egreene\Desktop\Output'

# Update this with the path to the input files'
$inputFiles = 'c:\users\egreene\Downloads\fwd2ndattemptquickmemo\*.lqm'


#main () {
$outputHtml= '<html><body>'
$outputText=""
$workfolder = $outputFolder + '\extracted'
$thumbsfolder = $outputFolder + '\thumbnails'
mkdir $workfolder
mkdir $thumbsfolder
get-childitem $inputFiles | foreach-object {
    write-host "Processing File: " 
    write-host $_.BaseName

    mkdir ($workfolder + '\' + $_.BaseName) -ErrorAction SilentlyContinue
    copy-item $_ work.zip -force
    expand-archive -LiteralPath work.zip -DestinationPath ($workfolder + '\' + $_.BaseName) -force
    remove-item work.zip

    $memoinfo = get-content ($workfolder + '\' + $_.BaseName + '\memoinfo.jlqm') -raw | convertfrom-json
    
    #Append the Text version of the output 
    $outputText += "`r`n-------------------------------------`r`n" 
    $outputText +=  $memoinfo.MemoObjectList.DescRaw

    #Append the HTML format version of the note to the ouput.
    $outputHTML += "<br> </br>-------------------------------------<br> </br>" 
    $outputHTML +=  $memoinfo.MemoObjectList.Desc

    #Copy out the thumbnail
    copy-item ($workfolder + '\' + $_.BaseName + '\images\*thumb.jpg') ($outputfolder + '\thumbnails')
}

$outputHtml +="</body></html>"
$outputHtml | out-file ($outputFolder + '\Output.Html')
$outputText | out-file ($outputFolder + '\Output.txt')

#end main()