/**
 * ExceptionEmailService.cls
 * Description: Inbound email handler to read SF Dev emails
 */
global class ExceptionEmailService implements Messaging.InboundEmailHandler {

    global Messaging.InboundEmailResult handleInboundEmail(
        Messaging.InboundEmail email,
        Messaging.InboundEnvelope env) {

        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        result.success = parseEmail(email.plainTextBody);

        return result;
    }

    public Boolean parseEmail(String emailBody) {

        // Create the exception email SObject and insert it
        ExceptionEmail emailObj = ExceptionEmail.parseEmail(emailBody);

        Exception__c exceptionRecord = new Exception__c();

        Account a = new Account(OrganizationId__c = emailObj.organizationId);
        if (a.OrganizationId__c != null) {
            exceptionRecord.Account__r = a;
        }

        // TODO: Something more clever than this
        Blob hash = Crypto.generateDigest('MD5', Blob.valueOf(emailObj.stacktrace));
        String uniqueString = EncodingUtil.convertToHex(hash).substring(0,20);
        exceptionRecord.UniqueName__c = uniqueString;
        Database.DmlOptions options = new Database.DmlOptions();
        options.allowFieldTruncation = true;

        if (String.isNotBlank(exceptionRecord.UniqueName__c)) {
            exceptionRecord.setOptions(options);
            Database.upsert(exceptionRecord, Exception__c.UniqueName__c);

            Occurrence__c occurrence = new Occurrence__c();
            occurrence.Exception__c = exceptionRecord.Id;
            occurrence.Cause__c = emailObj.cause;
            occurrence.Message__c = emailObj.message;
            occurrence.Stacktrace__c = emailObj.stacktrace;
            occurrence.Sandbox__c = emailObj.isSandbox;
            occurrence.UserId__c = emailObj.userId;
            occurrence.OrganizationId__c = emailObj.organizationId;
            occurrence.OccurrenceDate__c = System.now();

            Database.insert(occurrence, options);
        }

        return true;
    }
}
