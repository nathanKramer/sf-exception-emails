# Using Apex Email Services _and_ Apex Exception emails together


An example use case of Apex email services, and Apex exception emails


## Develop -> [Email Services](https://ap2.salesforce.com/email-admin/services/listEmailServicesFunction.apexp?retURL=%2Fui%2Fsetup%2FSetup%3Fsetupid%3DDevToolsIntegrate&setupid=EmailToApexFunction)

![Email Services Screenshot](/images/email-services.png)

Email services allow you to generate email addresses which are linked to an apex class intended to process the mail those addresses receive.

A generated email looks something like this:

exceptionlogger@33n9zo4kx670anv2qjs2dm7fcr69cswa2ql27qomdsm0hgsger.28-1i6r3eai.ap2.apex.salesforce.com

## Email Administration -> Apex [Exception Email](https://ap2.salesforce.com/apexpages/setup/apexExceptionEmail.apexp?retURL=%2Fui%2Fsetup%2FSetup%3Fsetupid%3DEmailAdmin&setupid=ApexExceptionEmail)

You can configure unhandled Salesforce exceptions in your org to be sent to an email address of your choosing.

The email format is quite ugly, but has most of the pertinent information.


Here is an example exception email (modified)
```
Sandbox

Apex script unhandled exception by user/organization: 00550000002dOS3/00D28000001i6R3
Source organization: 00D5000000021dC (null)
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

We can combine these two features.

By configuring Salesforce orgs to all point to the generated apex email service, we can begin to build up a more holistic picture of the exceptions and where they come from.

### Reg-wat?

![obligatory xkcd](https://imgs.xkcd.com/comics/perl_problems.png)

- [User/Organization Ids](http://www.regexpal.com/?fam=95657)
- [Stacktrace](http://www.regexpal.com/?fam=95656)

## Next Steps

If implementing this sort of thing in Salesforce, it would make sense to leverage the platform's reporting capabilities.

But there is all sorts of things that can be done.

- Plot trending graphs of change in exceptions per customer over time
- Calculate the mean frequency of a given exception, to get an idea of when it will next occur
- Store context / Domain Knowledge Expert info / "T Shirt" fixing size on the exception itself
- Empower the Salesforce team to respond to production bugs before the phone call comes in from the customer
- Slack Integration?

## [Show the people]

- [The object(s)](https://ap2.salesforce.com/a002800000jyx2p)
- [Throw some exceptions](https://c.ap2.visual.force.com/apex/BuggyPage?sfdc.tabName=01r28000000og3X)

## Test Pilot Feature?

In my view all of the above sounds like test pilot territory - especially given that we can _set the apex exception email over the tooling API_.

In other words, this feature could be as simple to turn on as a checkbox that says "track exceptions" - test pilot could conceivably make a tooling API call if it is checked.


## Any Questions?

<details> 
  <summary>Thanks</summary>

   Exception Cop would like to thank everyone for listening

   ![Exception Cop](http://imgc.allpostersimages.com/images/P-488-488-90/88/8815/7GXO300Z/posters/wwe-john-cena-light-blue-shirt-lifesize-standup.jpg)
</details>
