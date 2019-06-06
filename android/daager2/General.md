## reflection 

* can access methods and variables of class at runtime 
* since its creates at runtime difficult to debug stacktrace based on configuration which happens at runtime crash
* Annotation processing is same as reflection but does it at build time was used in dagger1 for creating instance alone but still having 
  runtime crash  
  
## Inversion of control (IOC)
 
 * When classes need dependencies, create the instance and provide to required classes known as IOC
 * providing dependency from outside makes it configurable and easy to make change in only on dependency
* component 
    every component should have a scope such as @singleton @activityscope
	searches for module's which provides the instances 
	anything that the application component holds should be singleton
	to access methods from application component you need to create methods in the component, this allows the share the component for dependencies
	
 * When we use @Inject for any class dagger2 first checks for its constructor where we have provided @inject if yes then we don't have to 
   use @provides annotation in the activity module like this 
   
   ```
   @Provides
    MainViewModel provideMainViewModel(DatabaseService databaseService,
                                       NetworkService networkService) {
        return new MainViewModel(databaseService, networkService);
    }
	```
 * Qualifier
   * Suppose if we are providing instances of same  method and if it has same type in dagger to we use qualifier to separate them. 
    ```
	
	Appmodule.class
	
	@Provides
 
    String provideDatabaseName() {
        return "dummy_db";
    }

    @Provides
   
    String provideApiKey() {
        return "SOME_API_KEY";
    }
	
	db.class
	
	private Context context;
    private String databaseName;
    private int version;

    @Inject
    public DatabaseService(@ApplicationContext Context context,
                           String databaseName,
                           Integer version) {
        // do the initialisation here
        this.context = context;
        this.databaseName = databaseName;
        this.version = version;
    }
	
	```
   * Above we have two String types which are passed to db class as constructor arguments, if you try to build it it would throw error saying that 
   "String is bound multiple times", we add qualifiers to avoid this issue. 
   * We can create qualifiers with @Qualifier such as 
   
   ```
    Qualifier
    @Retention(RetentionPolicy.SOURCE)
      public @interface DatabaseInfo {
       }
	   
	   and 
	   
	   @Qualifier
   @Retention(RetentionPolicy.SOURCE)
   public @interface NetworkInfo {
   }
	   
   ```
   
   * Now using this I can mention in the db class as below. 
   
   ```
   private Context context;
    private String databaseName;
    private int version;

    @Inject
    public DatabaseService(@ApplicationContext Context context,
                           @DatabaseInfo String databaseName,
                           @DatabaseInfo Integer version) {
        // do the initialisation here
        this.context = context;
        this.databaseName = databaseName;
        this.version = version;
    }
   
   ```
