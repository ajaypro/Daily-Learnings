# Activity

* [good practice for creating base activity](https://medium.com/@sandeeptengale/writing-good-baseactivity-class-for-android-activity-100636c81011)
* `android:excludeFromRecents="true"` - attribute to prevent the help activity from appearing on the recent apps (long-press Home) list. I also included
* `android:taskAffinity="com.mycompany.mymainapp.HelpActivity"` - where HelpActivity is the name of the help activity, to segregate the activity in its own task
* `android:launchMode="singleInstance"` - to prevent multiple instances of this app from being created each time the user invoked help.