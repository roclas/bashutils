
import com.liferay.registry.*
Registry registry = RegistryUtil.getRegistry()

//#######################
//########Transaction performance test
//#######################

//fooService=registry.getService(registry.getServiceReference("foo.service.FooLocalService"))
//fooClassLoader=fooService.getClass().getClassLoader()
//fooClass=fooClassLoader.loadClass(fooService.getClass().getName())
//methods = fooClass.getDeclaredMethods()
//for (i = 0; i < methods.length; i++) { System.out.println("METHOD=>"+methods[i].toString()); }

fooService=registry.getService(registry.getServiceReference("foo.NonTransactionalService"))
fooClassLoader=fooService.getClass().getClassLoader()
fooClass=fooClassLoader.loadClass(fooService.getClass().getName())


////reducing transactions (counted 23 after executing the following two lines)
//items=(fooClass.cast(fooService)).createManyItems(1000) //half a second
//(fooClass.cast(fooService)).updateManyItems(items) // less than a second

////not reducing the transactions (counted 3020  after executing the following 2 lines)
//items=(0..999).collect { ((fooClass.cast(fooService)).createOneItem()) } //6.5 seconds
//items.each{ foo -> (fooClass.cast(fooService)).updateOneItem(foo) } // 7 seconds

//Switching roles in 1 transaction
//(fooClass.cast(fooService)).updateRoles()

//Switching roles in 2 transactions
//(fooClass.cast(fooService)).updateRoles() 
(1..50).each{t-> (fooClass.cast(fooService)).updateRoles() }
