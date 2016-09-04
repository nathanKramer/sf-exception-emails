public with sharing class CheekySlackIntegration {

    @future(callout=true)
    public static void tellThePeople(String payload) {
        String endpointURL = 'https://hooks.slack.com/services/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';
        String imageURL = '';

        Http http = new Http();
        HttpRequest request = new HttpRequest();

        request.setEndpoint(endpointURL);
        request.setMethod('POST');

        request.setBody(payload);

        http.send(request);
    }

    public class Payload {
        public String text;
        public String channel;
        public Map<String, SlackAttachment> attachments;
    }

    public class SlackAttachment {
        public String pretext;
        public String fallback;
        public String color;
        public String title;
        public String title_link;
        public List<SlackField> fields;
    }

    public class SlackField {
        public String title;
        public String value;

        public SlackField(String title, String value) {
            this.title = title;
            this.value = value;
        }
    }
}
