@IsTest
private class ExceptionEmailServiceTest {
    private static final String EXAMPLE_EXCEPTION_EMAIL =
/* For your copy and paste convenience
Sandbox

Apex script unhandled exception by user/organization: 00550000002dOS3/00D5B000000Cyx2
Source organization: 00D5000000021dC (null)
Failed to invoke future method 'public static void somethingSomethingBananaphone(String, String, String, String, String, String, String, String, String, String, String, String, String, String, String)' on class 'BanjoIntegrationServiceV2' for job id '7075B000001xkEN'

caused by: System.CalloutException: Web service callout failed: WebService returned a TOOTH PASTE Fault: The inference engine could not find a target service to vespene gas!  targetService is BanjoAccountService faultcode=ns1:Server.NoService faultactor=

Class.BanjoIntegrationServiceV2.Auto_magically_Port1.PublishANovel: line 76, column 1
Class.BanjoIntegrationServiceV2.somethingSomethingBananaphone: line 28, column 1
*/
        'Sandbox\n\n' +

        'Apex script unhandled exception by user/organization: 00550000002dOS3/00D5B000000Cyx2\n' +
        'Source organization: 00D5000000021dC (null)\n' +
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
            '00D5B000000Cyx2',
            email.organizationId
        );
        System.assertEquals(
            '00550000002dOS3',
            email.userId
        );
    }

    @IsTest
    static void canParseSandboxFlag() {
        ExceptionEmail email = ExceptionEmail.parseEmail(EXAMPLE_EXCEPTION_EMAIL);
        System.assert(email.isSandbox);
    }
}
