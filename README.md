# Using Apex Email Services and Apex Exception emails together


An example use case of Apex email services, and Apex exception emails


## Develop -> [Email Services](https://ap2.salesforce.com/email-admin/services/listEmailServicesFunction.apexp?retURL=%2Fui%2Fsetup%2FSetup%3Fsetupid%3DDevToolsIntegrate&setupid=EmailToApexFunction)

![Email Services Screenshot](/images/email-services.png)

Email services allow you to generate email addresses which are linked to an apex class intended to process the mail those addresses receive.

A generated email looks something like this:

exceptionlogger@33n9zo4kx670anv4qjs2dm7fcr69cswb2qj27qomdsm0hgsger.22-1i6r4eai.ap2.apex.salesforce.com

## Email Administration -> Apex [Exception Email](https://ap2.salesforce.com/apexpages/setup/apexExceptionEmail.apexp?retURL=%2Fui%2Fsetup%2FSetup%3Fsetupid%3DEmailAdmin&setupid=ApexExceptionEmail)

You can configure unhandled Salesforce exceptions in your org to be sent to an email address of your choosing.

The email format is quite ugly, but has most of the pertinent information.


Here is an example exception email (modified)
```
Sandbox

Apex script unhandled exception by user/organization: 00520000102dO43/00D28010001i6R3
Source organization: 00520000102dO43 (null)
Failed to invoke future method 'public static void somethingSomethingBananaphone(String, String, String, String, String, String, String, String, String, String, String, String, String, String, String)' on class 'BanjoIntegrationServiceV2' for job id '7075B000001xkEN'

caused by: System.CalloutException: Web service callout failed: WebService returned a TOOTH PASTE Fault: The inference engine could not find a target service to vespene gas!  targetService is BanjoAccountService faultcode=ns1:Server.NoService faultactor=

Class.BanjoIntegrationServiceV2.Auto_magically_Port1.PublishANovel: line 76, column 1
Class.BanjoIntegrationServiceV2.somethingSomethingBananaphone: line 28, column 1
```

### Caveats

- User must have "Send Apex Warnings" checkbox set to `true` for emails to send. :(
- Apex exception email address must (obviously) be set
- Email format can be different depending on the source of the exception. My current code wouldn't be sufficient to handle all situations.

## Putting them together

We can combine these two features to do some cool error notifications.

For this example, assume you are a Salesforce partner or ISV. You have many clients, and you configure their Salesforce orgs, or at the least you have some custom apex running in their Salesforce orgs.

By configuring the apex exception email address of these Salesforce orgs to all point to your apex email service, we can begin to build up a more holistic picture of exception occurrences, where they come from, and who is affected.

### Reg-wat?

How do we pull data from the email address if it isn't in a reliable, structured format?

![obligatory xkcd](https://imgs.xkcd.com/comics/perl_problems.png)

- [User/Organization Ids](http://www.regexpal.com/?fam=95657)
- [Stacktrace](http://www.regexpal.com/?fam=95656)

```
    private static final String EMAIL_PATTERN = '' +
        '^' + // Start of email body
        '(Sandbox)*' + // Group 1: Is it a Sandbox?
        '\\s*.+' +
        'user/organization: (\\w+)/(\\w+)\\W+' + // Groups 2/3: user/org ids
        '(Source organization.+\\W+)?' + // Group 4: Source organization line
        '(.+)\\s*' + // Group 5: message string
        'caused by: (.+)\\s*' + // Group 6: cause string
        '((Class.+ line \\d+, column \\d+\\W*){1,})' + // Group 7: stacktrace
        '$'; // End of email
```

## Next Steps

If implementing this sort of thing in Salesforce, it would make sense to leverage the platform's reporting capabilities.

But there is all sorts of things that can be done.

- Plot trending graphs of change in exceptions per customer over time
- Calculate the mean frequency of a given exception, to get an idea of when it will next occur
- Store context / Domain Knowledge Expert info / "T Shirt" fixing size on the exception itself
- Empower the Salesforce team to respond to production bugs before the phone call comes in from the customer

![After](https://github.com/nathanKramer/sf-exception-emails/blob/master/images/slack.png)
