classdef Message < aws.Object
% MESSAGE Object to represent an SQS message
%
% Example:
%    receiveMessageResult = sqs.receiveMessage(queueUrl);
%    messages = receiveMessageResult.getMessages();
%    for n = 1:numel(messages)
%       id = messages{n}.getMessageId();
%       receiptHandle = messages{n}.getReceiptHandle();
%       body = messages{n}.getBody();
%    end


% Copyright 2018 The MathWorks, Inc.

methods
    function obj = Message(varargin)
        if nargin == 0
            % do nothing, don't set handle
        elseif nargin == 1
            if ~isa(varargin{1}, 'com.amazonaws.services.sqs.model.Message')
                write(logObj,'error','argument not of type com.amazonaws.services.sqs.model.Message');
            end
            obj.Handle = varargin{1};
        else
            write(logObj,'error','Invalid number of arguments');
        end
    end
end

end
