function getQueueAttributesResult = getQueueAttributes(obj, queueUrl, attributeNames)
% GETQUEUEATTRIBUTES Gets attributes for the specified queue URL
% Attribute names can be specified in a cell array or all attributes for the
% queue can be returned by using 'All' as the only entry in the cell array.
% A GetQueueAttributesResult object is returned. Attribute value are stored as
% character vectors.
%
% Example:
%    attributeNames = {'DelaySeconds', 'MaximumMessageSize'};
%    getQueueAttributesResult = sqs.getQueueAttributes(queueUrl, attributeNames);
%    attributes = getQueueAttributesResult.getAttributes();
%    maximumMessageSize = attributes('MaximumMessageSize');
%    delaySeconds = attributes('DelaySeconds');

% Copyright 2018 The MathWorks, Inc.

logObj = Logger.getLogger();

if ~ischar(queueUrl)
    write(logObj,'error','Expected queueURL of type character vector');
end
if ~iscell(attributeNames)
    write(logObj,'error','Expected attributeNames of type cell array');
end
if isempty(attributeNames)
    write(logObj,'error','Attribute entries cannot be empty');
end

% convert the attribute names cell array to a Java array list
attributeNamesJ = java.util.ArrayList();
for n = 1:numel(attributeNames)
    attributeNamesJ.add(string(attributeNames{n}));
end

% the results are returned as an internal AWS SDK map type this must be converted
% to a containers.Map before being returned
getQueueAttributesResultJ = obj.Handle.getQueueAttributes(string(queueUrl), attributeNamesJ);
getQueueAttributesResult = aws.sqs.model.GetQueueAttributesResult(getQueueAttributesResultJ);

end %function
