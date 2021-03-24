function setAttributeNames(obj, attributeNames)
% SETATTRIBUTENAMES Sets attributes to be returned along with each message
% A cell array  of attributes that need to be returned along with each message.
% The returned attributes include:
%   All: all values
%   ApproximateFirstReceiveTimestamp: the time the message was first received
%                                     from the queue (epoch time in milliseconds)
%   ApproximateReceiveCount: the number of times a message has been received
%                            across all queues but not deleted
%   AWSTraceHeader: Returns the AWS X-Ray trace header string
%   SenderId:
%     For an IAM user, the IAM user ID, e.g. ABCDEFGHI1JKLMNOPQ23R
%     For an IAM role, the IAM role ID, e.g. ABCDE1F2GH3I4JK5LMNOP:i-a123b456
%   SentTimestamp: the time the message was sent to the queue
%                (epoch time in milliseconds)
%   MessageDeduplicationId: returns the value provided by the producer that calls
%                         the SendMessage action
%   MessageGroupId: the value provided by the producer that calls the SendMessage
%                 action. Messages with the same MessageGroupId are returned in
%                 sequence
%   SequenceNumber: the value provided by Amazon SQS
%
% Example:
%    receiveMessageRequest = aws.sqs.model.ReceiveMessageRequest();
%    receiveMessageRequest.setQueueUrl(queueUrl);
%    attributeNames = {'ApproximateReceiveCount', 'SentTimestamp'};
%    receiveMessageRequest.setAttributeNames(attributeNames);

 % Copyright 2021 The MathWorks Inc.
 
if ~iscellstr(attributeNames) %#ok<ISCLSTR>
    logObj = Logger.getLogger;
    write(logObj,'error','Expected attributeNames to be a cell array of character vectors');
end

attributeNamesJ = java.util.ArrayList;
for n = 1:length(attributeNames)
    attributeNamesJ.add(string(attributeNames{n}));
end

obj.Handle.setAttributeNames(attributeNamesJ);

end