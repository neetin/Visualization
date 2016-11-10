## Setup

### Cocoapods

This project uses cocoapods as a dependency manager, if you have not setup cocoapods on your mac then setup now. 
Before installing cocoapods gem in you mac, make you system's ruby updated using this command in terminal: `sudo gem update --system`
install cocoapods with this command: `sudo gem install cocoapods`

You may get this prompt during the install process:

`rake's executable "rake" conflicts with /usr/bin/rake
Overwrite the executable? [yN]`

If so, just **enter y** to continue. (This warning is raised because the rake gem is updated as part of the install process. You can safely ignore it.)

** Follow these steps to add libraries: **

 1. Open terminal, navigate to you project source directory
 2. hit command: `pod install` or `pod update` (if you have already done pod install previously)
 3. Once all of the libraries downloaded successfully then you are good to go.
 4. Verify all the libraries which are listed on Podfile (found on root path of the project)
 5. Open ***work space*** file of the project, for this project open this file : **"GraphTest.xcworkspace"**