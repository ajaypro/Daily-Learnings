* [Deprecation of internal mobile app](http://adavis.info/2019/05/how-to-deprecate-an-internal-mobile-application.html)
* [Communicate between fragment & actvitiy using livedata](https://android.jlelse.eu/communicate-between-fragments-and-activity-using-livedata-631526d6357a)
* [app launch from zygote to activity](https://android.jlelse.eu/android-application-launch-explained-from-zygote-to-your-activity-oncreate-8a8f036864b)

### Viewmodel vs SavedStateinstance

* Viewmodel does not restore data when the system kills process of activity/fragment residing. 
* `onsavedInstanceState()` will save the state and also configuration change but for simple objects
* Therefore google has come up with `stateSavedInstance` that we give as an argument to viewmodel class for saving state. 
   [reference blogs](https://medium.com/@elye.project/architecture-viewmodel-vs-saveinstancestate-179f44d16c1)
