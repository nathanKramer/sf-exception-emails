/**
 * ExceptionEmail.cls
 * Description: Models an ExceptionEmail
 */
public class ExceptionEmail {
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

    public String organizationId;
    public String userId;
    public String stacktrace;
    public String message;
    public String emailBody;
    public String cause;
    public Boolean isSandbox;

    public static ExceptionEmail parseEmail(String emailBody) {
        ExceptionEmail email = new ExceptionEmail();
        Pattern emailPattern = Pattern.compile(EMAIL_PATTERN);
        Matcher emailMatcher = emailPattern.matcher(emailBody);

        if (emailMatcher.matches()) {
            System.debug(emailMatcher.groupCount());
            email.isSandbox = (emailMatcher.group(1) != null);
            email.userId = emailMatcher.group(2);
            email.organizationId = emailMatcher.group(3);
            email.message = emailMatcher.group(5);
            email.cause = emailMatcher.group(6);
            email.stacktrace = emailMatcher.group(7);
        } else {
            System.debug('No Match:\n\n' + emailBody);
        }
        return email;
    }
}
