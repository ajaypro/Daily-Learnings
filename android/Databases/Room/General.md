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
  
  
 
