## Upcoming features - Shared Storage 

* **Why** - Apps access broad amount of storage area just to make small storage such as accessing a image, downloading a file as such, and 
  after they been uninstalled the files are not cleared so **scoped-storage** will limit rboad access to shared storage into collections. 
* **Principles** 
    * All the files related to the app are been deleted when the app is uninstalled unless the users whats to keep it.
    * Protecting data such as user data like pdfs, personal images from external and internal storage are proected from others apps reading
      it. 
    * Unrestricted persmission to both app storage and media data, apps don't need to ask for permissions.
    * permission such as access_media_location is added so that apps can get information of medica location only if this is enabled
    * System Picker: In order to access other files except for these media files, we have to use System Picker which is accessed using 
      the Storage Access Framework.
      
  ## Resources
  
  [Video](https://www.youtube.com/watch?v=UnJ3amzJM94&list=PLWz5rJ2EKKc_xXXubDti2eRnIKU0p7wHd&index=42)
  [blogs](https://blog.mindorks.com/understanding-the-scoped-storage-in-android)
  
  ## Types of storage 
  
  **Bundle**
  * System keeps this bundle in RAM,
  * Bundle size is 100K so keep it small otherwise it would crashing your app with the `TransactionTooLargeException` error


