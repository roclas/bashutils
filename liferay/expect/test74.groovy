bundle = org.osgi.framework.FrameworkUtil.getBundle(com.liferay.portal.scripting.groovy.internal.GroovyExecutor.class);
//you should change it to com.liferay.server.admin.web.internal.scripting.ServerScripting.class , there is a breaking change after u46

/*
filter = org.osgi.framework.FrameworkUtil.createFilter("(&(objectClass=com.liferay.portal.kernel.messaging.Destination)(destination.name=liferay/background_task))");
*/
filter = org.osgi.framework.FrameworkUtil.createFilter("(objectClass=com.liferay.commerce.product.content.util.CPContentHelper)");

destinationServiceTracker = new org.osgi.util.tracker.ServiceTracker(bundle.getBundleContext(), filter, null);

destinationServiceTracker.open();

destinations = destinationServiceTracker.getService();

destinations.each { destination -> methods = destination.getClass().getDeclaredMethods();
	for (i = 0; i < methods.length; i++) { System.out.println("METHOD=>"+methods[i].toString()); };
};

destinationServiceTracker.close();
