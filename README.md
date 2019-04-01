# taiwanesedictionary
Taiwanese Dictionary for iOS

I just pushed the repository to GitHub. I think it is working.

I haven't touched this since 2014. Half the code is deprecated and I had to fiddle with some settings to get it to compile again. I don't really know how to use source control, but I had set up a local git repository when I was working on this in 2014 so I can still see older commit messages.

I used ParseKit (which is/was a Pod) probably for regular expressions (?) - something about the Pod setup means we have to open the project by opening 'Taiwanese.xcworkspace', otherwise something breaks. I'm sure there is a better way to do this now.

It would be nice to rewrite everything in Swift, but I don't know if I would really spend the time to do it.

Old feature ideas
1. Core Data
2. Speech Synthesis
3. Refactor transliteration
4. Improve Settings using table view
5. Make entries selectable using Text Views
6. Fix bug involving the pull to sort search results and the gray line that appears when searching long then short results
7. -[NSKeyedUnarchiver initForReadingWithData:]: data is NULL for Recents and Favorites 
