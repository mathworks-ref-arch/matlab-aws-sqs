classdef DeleteQueueResult < aws.Object
% DELETEQUEUERESULT Object to represent the result of a deleteMessage call
%
% Example:
%    deleteQueueResult = sqs.deleteQueue(queueUrl);
%    tf = strcmp(deleteQueueResult.toString(), '{}');


% Copyright 2018 The MathWorks, Inc.

methods
    function obj = DeleteQueueResult(varargin)
        if nargin == 1
            if ~isa(varargin{1}, 'com.amazonaws.services.sqs.model.DeleteQueueResult')
                logObj = Logger.getLogger();
                write(logObj,'error','argument not of type com.amazonaws.services.sqs.model.DeleteQueueResult');
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
