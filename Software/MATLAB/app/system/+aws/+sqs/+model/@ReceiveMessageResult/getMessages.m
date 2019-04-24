function messages = getMessages(obj)
% GETMESSSAGES Returns a cell array of Message objects
%
% Example:
%    receiveMessageResult = sqs.receiveMessage(queueUrl);
%    messages = receiveMessageResult.getMessages();

% Copyright 2018 The MathWorks, Inc.

% get a Java list of topics, type com.amazonaws.internal.SdkInternalList<T>
messagesListJ = obj.Handle.getMessages();

messages = {};
messagesListIterator = messagesListJ.iterator;

while messagesListIterator.hasNext()
    messages{end+1} = aws.sqs.model.Message(messagesListIterator.next()); %#ok<AGROW>
end

end
