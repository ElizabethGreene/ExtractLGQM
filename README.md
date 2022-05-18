# ExtractLGQM
A powershell script to extract the text from LG QuickMemo+ files

LG mobile phones ship with a fantastic liitle note taking app called QuickMemo+.  Unfortunately that app is not available on any other platform, so changing phone brands means that content is lost.

In the app there is an option where you can share QuickMemos with others.  Selecting this, selecting all the memos, and sharing to gmail creates an email with many .lqm files attached to it.  This .lqm file format is the QuickMemo data with one memo per file.

Reverse engineering and extracting .lqm files:
- The first two bytes of each file is  'PK', indicating it is a .zip file.
- Expanding the .zip file yields this folder structure:
│   memoinfo.jlqm
│   metadata.mtd
├───audios
├───drawings
├───images
│       20220325034400398d675d83fbbd20045thumb.jpg
└───videos
- memoinfo.jlqm is JSON data and contains the memo as text and html
- images\(Long number that looks like a date in yymmddhhmmss format)(unknownvalue)thumb.jpg appears to be what the memo looked like on the screen of the source device

ExtractLQMs.ps1 is a quick powershell script that extracts the contents of LG QuickMemo+ lqm files into a usable format.  To use it, save all the .lqm files to a folder, open the script, change the input and output paths, and run the script.

The script has 4 outputs.
Output.txt contains the notes in text format.
Output.html contains the notes in HTML/browser format.
Thumbs\ is a folder that contains the thumbnail images for each of the notes.
Extracted\ is a folder that contains all of the extracted content for each of the notes. 
