/**
 * ExceptionEmailService.cls
 * Description: Inbound email handler to read SF Dev emails
 */
global class ExceptionEmailService implements Messaging.InboundEmailHandler {

    global Messaging.InboundEmailResult handleInboundEmail(
        Messaging.InboundEmail email,
        Messaging.InboundEnvelope env) {

        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        result.success = parseEmail(email);

        return result;
    }

    private Boolean parseEmail(Messaging.InboundEmail email) {

        String emailBody = '';
        emailBody = email.plainTextBody;
        ExceptionEmail exceptionEmail = new ExceptionEmail(emailBody);

        // Create the exception email SObject and insert it

        Database.DmlOptions options = new Database.DmlOptions();
        options.allowFieldTruncation = true;
        return true;
    }
}