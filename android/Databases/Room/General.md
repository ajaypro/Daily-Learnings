## Basics 

* Wrapper around sqlite which earlier had cursor objects to work which was difficult. 
* Room is a ORM (Object relation mapping)
  * It abstracts mapping of variables defined in POJO or model classes to rows in the table that should 
    be moved using cursors. 
  * When we give an object to room it internally maps the object attributes to the columns of the table and saves as an object
     and when we retreive it returns a object with data and maps it to variables in pojo class
* When creating a entity we always mention @Entity(tableName = "users") otherwise it would be obfuscated by proguard. 
 
 ```
    @Entity(tableName = "user") // this avoids proguard to obfuscate my model class
  data class User(

    @PrimaryKey(autoGenerate = true)
    var id: Long =0,

    @ColumnInfo(name = "name")
    var name: String,
    
    @Ignore // Use ignore to specify the field to be used and not be persisted in room
    var selected: Boolean = false
 ```
 * Room allows us to customize queries 
 
 ```
    @Query("SELECT * FROM user")
    fun getAllUsers():Single<List<User>>

    @Query("SELECT * FROM user WHERE id = :id LIMIT 1")
    fun getUserById(id: Long): Single<User>

    @Query("SELECT count(*) FROM user")
    fun count(): Single<Int>
 ```
 * While creating a room db we create a abstract class extending `RoomDatabase()` class and annotating class with `@Database`
  and give `entities, version` and `exportSchema = false` as we don't want room to export schema to our android file system.
  
 * Room provides type convertors as it does not allow to store data types other than primitives, so adding Date of birth attribute 
  to User table we will add `@TypeConvertor` so that room stores them in converted form 
  Type convertor for Date datatype and  
  ```
  class Convertor {

    @TypeConverter
    fun fromTimestamp(value: Long) = value?.let { Date(it) }

    @TypeConverter
    fun fromDate(date: Date) = Date().time
}
  ```
   we mention them in the databaseservice class
   
   ```
   @Database(
    entities = [ User::class,
                 Address::class],
    version = 1,
    exportSchema = false)
**@TypeConverters(Convertor::class)**
abstract class DataBaseService: RoomDatabase() {

    // abstract method dao to implement and access the query methods of db
    abstract fun userDao(): UserDao

    abstract fun addressDao(): AddressDao

    fun dummyData() = "Dummy data"
   ```
 ## Migration 
 
 * When we add a column to table or alter we have to write and include migrations in dagger2 application module (if your using dagger2)
  We can only add or alter we cannot delete tables as it will be in production. 
 * Added pincode column in address table so the below migration
  
  ``` 
val MIGRATIONS1_2 = object: Migration(1,2){

    override fun migrate(database: SupportSQLiteDatabase) {
        database.execSQL("ALTER TABLE addresses ADD COLUMN pincode INTEGER")
    }
}
  ```
  * Roomdb will store boolean values as 1 and 0 so while creating table query should be 
    e.g `isValid INTEGER NON NULL` here non-null will be true always as by default value of room is 0 which is false. 
    
 ## Pre-packed db 

* Either prefill room db with data from apk or download from cloud, to do this we use 

```
 Room.databaseBuilder(appContext, TestDatabase.class, "Sample.db")
  .createFromFile(File("myPath"))
  .build()
```
* room reads the downloaded file so need to set view permissions .

* to pack in apk we need to place in assets folder and use below code 
```
 Room.databaseBuilder(appContext, TestDatabase.class, "Sample.db")
  .createFromAsset(File("database/myapp.db"))
  .build()
```

* @Relation annotation can be added to object as well
  which tells the actuall relation between two entities 
```
data class PetAndOwner(
  @Embedded val owner: Owner,
  @Relation(
    parentColumn = "ownerId",
    entityColumn = "petOwnerId"),
val pet: Pet)
```
  
 
