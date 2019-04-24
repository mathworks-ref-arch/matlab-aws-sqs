classdef DeleteQueueResult < aws.Object
% DELETEQUEUERESULT Object to represent the result of a deleteMessage call
%
% Example:
%    deleteQueueResult = sqs.deleteQueue(queueUrl);
%    tf = strcmp(deleteQueueResult.toString(), '{}');


% Copyright 2018 The MathWorks, Inc.

methods
    function obj = DeleteQueueResult(varargin)
        if nargin == 0
            % do nothing, don't set handle
        elseif nargin == 1
            if ~isa(varargin{1}, 'com.amazonaws.services.sqs.model.DeleteQueueResult')
                write(logObj,'error','argument not of type com.amazonaws.services.sqs.model.DeleteQueueResult');
            end
            obj.Handle = varargin{1};
        else
            write(logObj,'error','Invalid number of arguments');
        end
    end
end

end
