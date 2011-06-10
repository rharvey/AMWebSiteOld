package am

import grails.test.*

class ClientTests extends GrailsUnitTestCase {
	def client
	
    protected void setUp() {
        super.setUp()
	
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testSave() {
		client = new Client()
		
    }
}
