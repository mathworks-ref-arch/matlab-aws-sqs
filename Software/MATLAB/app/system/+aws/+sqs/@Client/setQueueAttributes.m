function setQueueAttributesResult = setQueueAttributes(obj, queueUrl, attributeMap)
% SETQUEUEATTRIBUTES Sets the value of one or more queue attributes
% When you change a queue's attributes the change can take up to 60 seconds
% for the attributes to propagate throughout the SQS system.
% However, changes made to the MessageRetentionPeriod attribute can take up
% to 15 minutes. A list of parameters can be found in the parameters section at:
% https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/index.html?com/amazonaws/services/sqs/AmazonSQSClient.html
%
% Example:
%    keySet = {'DelaySeconds', 'MaximumMessageSize'};
%    % Corresponding values to the keyset entry/entries
%    valueSet = {3, 2000};
%    % Make container map of keySet and valueSet
%    M = containers.Map(keySet,valueSet);
%    % Set the queue attributes
%    setQueueAttributesResult = sqs.setQueueAttributes(queueUrl, M);
%    tf = strcmp(setQueueAttributesResult.toString(), '{}');

% Copyright 2018 The MathWorks, Inc.

% Create logger reference
logObj = Logger.getLogger();
if ~ischar(queueUrl)
    write(logObj,'error','Expected queue name of type character vector');
end
if ~isa(attributeMap,'containers.Map')
    write(logObj,'error','Expected attributes to be of type containers.Map');
end
if isempty(attributeMap)
    write(logObj,'error','Attribute map cannot be empty');
end

% extract keys and values from the Map
attributeKeys = keys(attributeMap);
attributeVals = values(attributeMap);

% Create a java hashtable
attributeTableJ = java.util.Hashtable;
% Map keys to values
for i=1:length(attributeKeys)
    attributeTableJ.put(string(attributeKeys{i}), string(attributeVals{i}));
end
% Call the API to set the queue attributes
setQueueAttributesResultJ = obj.Handle.setQueueAttributes(string(queueUrl), attributeTableJ);
setQueueAttributesResult = aws.sqs.model.SetQueueAttributesResult(setQueueAttributesResultJ);

end % function
