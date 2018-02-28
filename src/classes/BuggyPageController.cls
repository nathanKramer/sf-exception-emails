public with sharing class BuggyPageController {

    private static final String FAKE_CALLOUT_EXCEPTION = 'Sandbox\n\n' +
        'Apex script unhandled exception by user/organization: 00560000012dOS4/00D28000121i6R4\n' +
        'Source organization: 00D6000001021dD (null)\n' +
        'Failed to invoke future method \'public static void somethingSomethingBananaphone(String, String, String, String, String, String, String, String, String, String, String, String, String, String, String)\' on class \'BanjoIntegrationServiceV2\' for job id \'7075B000001xkEN\'\n\n' +

        'caused by: System.CalloutException: Web service callout failed: WebService returned a TOOTH PASTE Fault: The inference engine could not find a target service to vespene gas!  targetService is BanjoAccountService faultcode=ns1:Server.NoService faultactor=\n\n' +

        'Class.BanjoIntegrationServiceV2.Auto_magically_Port1.PublishANovel: line 76, column 1\n' +
        'Class.BanjoIntegrationServiceV2.somethingSomethingBananaphone: line 28, column 1';

    private static final String FAKE_INDEX_ERROR = '' +
        'Apex script unhandled exception by user/organization: 00560000012dOS4/00D28000121i6R4\n' +
        'Source organization: 00D6000001021dD (null)\n' +
        'A list index was, quite frankly, way out of range. Do you think this is a game? \'public static void unforseenConsequences(Decimal)\' on class \'IceCreamTruck\' for job id \'7075B000001xkEN\'\n\n' +
        'caused by: System.IndexError: Did you off by one again? ffs\n\n' +
                'Class.ApexFizzBuzz.uWotM8: line 2, column 1\n' +
                'Class.ApexFizzBuzz.isItDivisibleBy15_5: line 28, column 1';

    private static final String FAKE_NULLPOINTER_EXCEPTION = '' +
        'Apex script unhandled exception by user/organization: 00560000012dOS4/00D28000001i7ff\n' +
        'Source organization: 00D6000001021dD (null)\n' +
        'V V bad. Shut everything down. \'public static void nooooope(Boolean)\' on class \'Harambe\' for job id \'7075B000001xkEN\'\n\n' +
        'caused by: System.NullPointerException: faultcode=ns1:Server.NoService faultactor=\n\n' +
                'Class.Yee.SomeClass.yeeMethod: line 76, column 1\n' +
                'Class.Yee.SomeClass.yeeMethod_19: line 28, column 1';

    public void throwFakeNullpointer() {
        new ExceptionEmailService().parseEmail(FAKE_NULLPOINTER_EXCEPTION);
    }

    public void throwFakeCalloutException() {
        new ExceptionEmailService().parseEmail(FAKE_CALLOUT_EXCEPTION);
    }

    public void throwFakeListIndexError() {
        new ExceptionEmailService().parseEmail(FAKE_INDEX_ERROR);
    }

    public void throwRealNullPointer() {
        String s = null;
        s.capitalize();
    }

    public void throwRealCalloutException() {
        Http h = new Http();
        h.send(new HttpRequest());
    }

    public void throwRealIndexError() {
        List<Integer> integers = new List<Integer> {
            0,
            1,
            2
        };
        Integer noooope = integers[3];
    }

    public void throwFakeException() {
        //Messaging.reserveSingleEmailCapacity(1);
        //Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        //String[] toAddresses = new String[] {
        //    'exceptionlogger@33n9zo4kx670anv2qjs2dm7fcr69cswa2ql27qomdsm0hgsger.28-1i6r3eai.ap2.apex.salesforce.com'
        //};
        //mail.setToAddresses(toAddresses);
        //mail.setSenderDisplayName('SF Exception');
        //mail.setSubject('Developer Script Exception');
        //mail.setPlainTextBody(FAKE_EXCEPTION);
        //Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}
