@IsTest
private class ExceptionEmailServiceTest {
    private static final String EXAMPLE_EXCEPTION_EMAIL =
/* For your copy and paste convenience
Sandbox

Apex script unhandled exception by user/organization: 00550000122dOS4/00D5B000000C12E4
Source organization: 00D5000001221dD (null)
Failed to invoke future method 'public static void somethingSomethingBananaphone(String, String, String, String, String, String, String, String, String, String, String, String, String, String, String)' on class 'BanjoIntegrationServiceV2' for job id '7075B000001xkEN'

caused by: System.CalloutException: Web service callout failed: WebService returned a TOOTH PASTE Fault: The inference engine could not find a target service to vespene gas!  targetService is BanjoAccountService faultcode=ns1:Server.NoService faultactor=

Class.BanjoIntegrationServiceV2.Auto_magically_Port1.PublishANovel: line 76, column 1
Class.BanjoIntegrationServiceV2.somethingSomethingBananaphone: line 28, column 1
*/
        'Sandbox\n\n' +

        'Apex script unhandled exception by user/organization: 00550000122dOS4/00D5B000000C12E4\n' +
        'Source organization: 00D5000001221dD (null)\n' +
        'Failed to invoke future method \'public static void somethingSomethingBananaphone(String, String, String, String, String, String, String, String, String, String, String, String, String, String, String)\' on class \'BanjoIntegrationServiceV2\' for job id \'7075B000001xkEN\'\n\n' +

        'caused by: System.CalloutException: Web service callout failed: WebService returned a TOOTH PASTE Fault: The inference engine could not find a target service to vespene gas!  targetService is BanjoAccountService faultcode=ns1:Server.NoService faultactor=\n\n' +

        'Class.BanjoIntegrationServiceV2.Auto_magically_Port1.PublishANovel: line 76, column 1\n' +
        'Class.BanjoIntegrationServiceV2.somethingSomethingBananaphone: line 28, column 1';

    // Nosey unit tests below
    // Make sure each regex is doing its job.

    @IsTest
    static void canParseStacktrace() {
        ExceptionEmail email = ExceptionEmail.parseEmail(EXAMPLE_EXCEPTION_EMAIL);
        System.assertEquals(
            'Class.BanjoIntegrationServiceV2.Auto_magically_Port1.PublishANovel: line 76, column 1\n' +
            'Class.BanjoIntegrationServiceV2.somethingSomethingBananaphone: line 28, column 1',
            email.stacktrace
        );
    }

    @IsTest
    static void canParseCause() {
        ExceptionEmail email = ExceptionEmail.parseEmail(EXAMPLE_EXCEPTION_EMAIL);
        System.assertEquals(
            'System.CalloutException: Web service callout failed: WebService returned a TOOTH PASTE Fault: The inference engine could not find a target service to vespene gas!  targetService is BanjoAccountService faultcode=ns1:Server.NoService faultactor=',
            email.cause
        );
    }

    @IsTest
    static void canParseMessage() {
        ExceptionEmail email = ExceptionEmail.parseEmail(EXAMPLE_EXCEPTION_EMAIL);
        System.assertEquals(
            'Failed to invoke future method \'public static void somethingSomethingBananaphone(String, String, String, String, String, String, String, String, String, String, String, String, String, String, String)\' on class \'BanjoIntegrationServiceV2\' for job id \'7075B000001xkEN\'',
            email.message
        );
    }

    @IsTest
    static void canParseOrgAndUserId() {
        ExceptionEmail email = ExceptionEmail.parseEmail(EXAMPLE_EXCEPTION_EMAIL);
        System.assertEquals(
            '00D5B000000C12E4',
            email.organizationId
        );
        System.assertEquals(
            '00550000122dOS4',
            email.userId
        );
    }

    @IsTest
    static void canParseSandboxFlag() {
        ExceptionEmail email = ExceptionEmail.parseEmail(EXAMPLE_EXCEPTION_EMAIL);
        System.assert(email.isSandbox);
    }

    @IsTest
    static void visualForcePageError() {
        String vfPageError = 'Apex script unhandled exception by user/organization: 00528000005c4wJ/00D28001231i6R4\n\n' +
        'Visualforce Page: /apex/BuggyPage\n\n\n' +
        'caused by: System.CalloutException: Endpoint can not be null\n\n\n' +
        'Class.BuggyPageController.throwRealCalloutException: line 48, column 1';

        ExceptionEmail email = ExceptionEmail.parseEmail(vfPageError);
        System.assertEquals(false, email.isSandbox);
        System.assertEquals('00528000005c4wJ', email.userId);
        System.assertEquals('00D28001231i6R4', email.organizationId);
        System.assertEquals('00D28001231i6R4', email.organizationId);
        System.assertEquals('Visualforce Page: /apex/BuggyPage', email.message);
        System.assertEquals('System.CalloutException: Endpoint can not be null', email.cause);
        System.assertEquals('Class.BuggyPageController.throwRealCalloutException: line 48, column 1', email.stacktrace);
    }

}
