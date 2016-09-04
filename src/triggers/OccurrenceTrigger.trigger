trigger OccurrenceTrigger on Occurrence__c (before insert) {

    Occurrence__c occurrence = Trigger.new[0];
    Exception__c e = [SELECT Id, Name, Label__c, Occurrences__c, Context__c, Account__c FROM Exception__c WHERE Id = :occurrence.Exception__c];
    Account a = [SELECT Id, Name, SlackChannel__c FROM Account WHERE Id = :e.Account__c];

    Map<String, String> attachments = new Map<String, String>();
    String errorMessage = occurrence.Message__c;
    errorMessage = errorMessage.replace('\'', '`');

    CheekySlackIntegration.Payload pLoad = new CheekySlackIntegration.Payload();
    CheekySlackIntegration.SlackAttachment attachment = new CheekySlackIntegration.SlackAttachment();
    attachment.title = a.Name + ' ' + e.Name;
    pLoad.channel = a.SlackChannel__c;
    pLoad.text = '_' + a.Name + '_ have experienced an exception\n\n' + errorMessage + '\n```' + occurrence.Stacktrace__c + '\n```\n';

    if (String.isBlank(e.Label__c)) {
        pLoad.text += '\nThis is an _unqualified_ exception. If you know the context please fill it in on SFDC';
    }
    attachment.title_link = 'https://ap2.salesforce.com/' + e.Id;
    attachment.color = '#EE6666';
    attachment.fallback = 'Click here for full information';
    String label = String.isBlank(e.Label__c) ? 'Unqualified' : e.Label__c;
    attachment.fields = new List<CheekySlackIntegration.SlackField>{
        new CheekySlackIntegration.SlackField('Label', label),
        new CheekySlackIntegration.SlackField('Occurrences', String.valueOf(e.Occurrences__c))
    };

    pLoad.attachments = new Map<String, CheekySlackIntegration.SlackAttachment> {
        'exception' => attachment
    };

    System.debug('\n' + JSON.serializePretty(pLoad));
    CheekySlackIntegration.tellThePeople(JSON.serializePretty(pLoad));
}
