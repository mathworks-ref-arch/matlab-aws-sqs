classdef DeleteMessageResult < aws.Object
% DELETEMESSAGERESULT Object to represent the result of a deleteMessage call
%
% Example:
%    deleteMessageResult = sqs.deleteMessage(queueUrl, receiptHandle);
%    tf = strcmp(deleteMessageResult.toString(), '{}');

% Copyright 2018 The MathWorks, Inc.

methods
    function obj = DeleteMessageResult(varargin)
        if nargin == 1
            if ~isa(varargin{1}, 'com.amazonaws.services.sqs.model.DeleteMessageResult')
                logObj = Logger.getLogger();
                write(logObj,'error','argument not of type com.amazonaws.services.sqs.model.DeleteMessageResult');
            else
                obj.Handle = varargin{1};
            end
        else
            logObj = Logger.getLogger();
            write(logObj,'error','Invalid number of arguments');
        end
    end
end

end
