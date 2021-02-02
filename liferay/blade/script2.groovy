
import com.liferay.registry.*
Registry registry = RegistryUtil.getRegistry()

//#######################
//########MY CODE
//#######################

fooService=registry.getService(registry.getServiceReference("foo.service.FooLocalService"))
fooClassLoader=fooService.getClass().getClassLoader()
fooClass=fooClassLoader.loadClass(fooService.getClass().getName())

//System.out.println("\n\n service="+fooService)
//methods = fooClass.getDeclaredMethods()
//for (i = 0; i < methods.length; i++) { System.out.println("METHOD=>"+methods[i].toString()); }
//text=(fooClass.cast(fooService)).sayHello()
//System.out.println("service saying hello: "+text)

//item=(fooClass.cast(fooService)).createOneItem(1L)
//(fooClass.cast(fooService)).deleteFoo(1L)
//System.out.println("item created : "+item)

//reducing transactions (counted 23 after executing the following two lines)
//items=(fooClass.cast(fooService)).createManyItems(1000) //half a second
//(fooClass.cast(fooService)).updateManyItems(items) // less than a second

//not reducing the transactions (counted 3020  after executing the following 2 lines)
items=(0..999).collect { ((fooClass.cast(fooService)).createOneItem()) } //6.5 seconds
items.each{ foo -> (fooClass.cast(fooService)).updateOneItem(foo) } // 7 seconds

