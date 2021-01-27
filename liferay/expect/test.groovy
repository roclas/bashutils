

import com.liferay.portal.kernel.service.UserLocalServiceUtil;
import com.liferay.registry.*;

System.out.println("Users count from file: "+UserLocalServiceUtil.getUsersCount());
Registry registry = RegistryUtil.getRegistry();

#ignore this line

System.out.println ("=>hello world");
for (i = 0; i <10; i++) { 
		System.out.println("->Helo World")
}; 

#######################
########OTHER STUFF
#######################
conversationService=registry.getService(registry.getServiceReference("conversation.Conversation"));
conversationClassLoader=conversationService.getClass().getClassLoader();
conversationClass=conversationClassLoader.loadClass(conversationService.getClass().getName());
reply=(conversationClass.cast(conversationService)).reply("hello");
System.out.println("the service replied: "+reply);


