#  Contacts

This is a coding challenge that requires me fetch a list of contact form this [endpoint](https://demomedia.co.uk/files/contacts.json). It should have:
- A contact list page
- A profile detail page
- Data persistence
- Avatars for userImage
- Bonus: Page load and transition animations
<img src="https://github.com/ji3g4kami/Contacts/blob/master/Contact.gif" width="300" height="533">


## Data flow
### Contact Data
Generally, contact list data is populated by the user, and then backup the data to the server. In this coding test, we cannot update our data to the server; thus, the single source of truth would be the [endpoint](https://demomedia.co.uk/files/contacts.json) provided. Realm here is simply for data-persistence and should be synced with endpoint.    

- With internet connection: Endpoint `Contact` →  Realm `RContact` →  Views `ContactViewModel` → UserDefaults `ImageURL`
- Without internet connection: Realm → updateUI  
    
[Note] To ensure the data comes from Realm instead of `URLSession` Cache, I 've set cache policy to `.reloadIgnoringLocalAndRemoteCacheData`     
[Note] You can view the entries of Realm with [RealmReader](https://apps.apple.com/app/realm-browser/id1007457278). You can get the location of database by `print(Realm.Configuration.defaultConfiguration.fileURL!)`        
[Note] `updatedAt is -1`  or  `phoneNumber is N/A` stands for `nil` data from endpoint.  
<img src="https://github.com/ji3g4kami/Contacts/blob/master/Realm.png" width="500" height="102">

### Image Data
Inside the profile view, we can tap on the profile image to update it. The [endpoint](https://demomedia.co.uk/files/contacts.json) did not provided the icon image. Thus, it's quite reasonable to generate a random image from [avatar](http://avatars.adorable.io) and store the `imageURL` in `UserDefaults`. Why not store in Realm? First, the endpoint does not provide adding `imageURL`. Secondly. each time the endpoint with no image data would require extra effort to zip old  data with the new data, which seems not worth of doing it.

## Project setup
- Environment: Xcode 11.4, Swift 5.
- Platform: iPhone only, requires iOS 13.4.
- Dependencies: [SnapKit](https://github.com/SnapKit/SnapKit) 5.0.1, [Kinfisher](https://github.com/onevcat/Kingfisher) 5.13.4; [RealmSwift](https://github.com/realm/realm-cocoa) with Swift Package Mnager.
- Press ⌘ + R to run on a simulator or a real device.

## Unit Test
- Testing with Decoding contacts from endpoint. Press ⌘ + U to run the test.
