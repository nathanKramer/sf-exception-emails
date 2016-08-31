/**
 * ExceptionEmail.cls
 * Description: Models an ExceptionEmail
 */
public class ExceptionEmail {
    public String organizationId;
    public String userId;
    public String stacktrace;
    public String message;
    public String emailBody;
    public String cause;
    public Boolean isSandbox;

    private static final List<PotentialExceptionEmailData> POTENTIAL_DATA_SOURCES =
        new List<PotentialExceptionEmailData> {
            new UserAndOrganizationIds(),
            new Stacktrace(),
            new IsSandbox(),
            new CausedBy(),
            new ExceptionMessage()
        };

    public ExceptionEmail(String emailBody) {
        this.emailBody = emailBody;
        this.parse();
    }

    private void parse() {
        for (PotentialExceptionEmailData potentialDataSource : POTENTIAL_DATA_SOURCES) {
            potentialDataSource.read(this);
        }
    }

    public abstract class PotentialExceptionEmailData {
        private Pattern regexPattern;

        public PotentialExceptionEmailData(String regex) {
            this.regexPattern = Pattern.compile(regex);
        }

        public void read(ExceptionEmail exceptionEmail) {
            Matcher matcher = regexPattern.matcher(exceptionEmail.emailBody);
            if (matcher.matches()) {
                useInformation(matcher, exceptionEmail);
            }
        }

        protected abstract void useInformation(Matcher matcher, ExceptionEmail exceptionEmail);
    }

    //--------------------------------
    // Information sources below
    //--------------------------------

    public class ExceptionMessage extends PotentialExceptionEmailData {
        public ExceptionMessage() {
            super('user/organization.+\\W+(Source organization.+\\W+)?(.+)');
        }

        protected override void useInformation(Matcher matcher, ExceptionEmail exceptionEmail) {
            exceptionEmail.message = matcher.group(2);
        }
    }

    public class Stacktrace extends PotentialExceptionEmailData {
        public Stacktrace() {
            super('(Class.+ line \\d+, column \\d+\\W*){1,}$');
        }

        protected override void useInformation(Matcher matcher, ExceptionEmail exceptionEmail) {
            exceptionEmail.stacktrace = matcher.group(0);
        }
    }

    public class IsSandbox extends PotentialExceptionEmailData {
        public IsSandbox() {
            super('^Sandbox');
        }

        protected override void useInformation(Matcher matcher, ExceptionEmail exceptionEmail) {
            exceptionEmail.isSandbox = true;
        }
    }

    public class CausedBy extends PotentialExceptionEmailData {
        public CausedBy() {
            super('caused by: (.+)');
        }

        protected override void useInformation(Matcher matcher, ExceptionEmail exceptionEmail) {
            exceptionEmail.cause = matcher.group(1);
        }
    }

    public class UserAndOrganizationIds extends PotentialExceptionEmailData {
        public UserAndOrganizationIds() {
            super('user/organization: (\\w+)/(\\w+)');
        }

        protected override void useInformation(Matcher matcher, ExceptionEmail exceptionEmail) {
            exceptionEmail.userId = matcher.group(1);
            exceptionEmail.organizationId = matcher.group(2);
        }
    }
}
