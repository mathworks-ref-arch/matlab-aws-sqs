classdef testSQSClient < matlab.unittest.TestCase
    % TESTCLIENT Unit Test for the Amazon SQS Client
    %
    % The test suite exercises the basic operations on the SQS Client.

    % Copyright 2018 The MathWorks, Inc.

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Please add your test cases below
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties
        %Create logger reference
        logObj = Logger.getLogger();
    end


    methods (TestMethodSetup)
        function testSetup(testCase)
            testCase.logObj = Logger.getLogger();
            testCase.logObj.DisplayLevel = 'verbose';
        end
    end


    methods (Test)
        function testConstructor(testCase)
            write(testCase.logObj,'debug','Testing testConstructor');
            % Create the object
            sqs = aws.sqs.Client();

            testCase.verifyClass(sqs,'aws.sqs.Client');
        end

        function testInitialization(testCase)
            write(testCase.logObj,'debug','Testing testInitialization');
            % Create the client and initialize
            sqs = aws.sqs.Client();
            sqs.useCredentialsProviderChain = false;
            sqs.initialize();
            testCase.verifyNotEmpty(sqs.Handle);
            sqs.shutdown;
        end

        function testInitializationOtherCredentials(testCase)
            write(testCase.logObj,'debug','Testing testInitializationOtherCredentials');
            % Create the client and initialize using a temp copy of the
            % credentials file in the same directory
            currentCreds = which('credentials.json');
            [pathstr,~,~] = fileparts(currentCreds);

            newCreds = fullfile(pathstr, 'testInitializationOtherCredentials.json');
            copyfile(currentCreds,newCreds);

            sqs = aws.sqs.Client();
            sqs.useCredentialsProviderChain = false;
            sqs.credentialsFilePath = newCreds;
            sqs.initialize();

            testCase.verifyNotEmpty(sqs.Handle);
            delete(newCreds);
            sqs.shutdown();
        end

        % Test that queue prefix returns one and only one match
        function testQueuePrefix(testCase)
            write(testCase.logObj,'debug','Testing testQueuePrefix');
            % Create the client
            sqs = aws.sqs.Client();
            sqs.useCredentialsProviderChain = false;
            sqs.initialize();

            % Create a queue
            uniqName = lower(matlab.lang.makeValidName(['com.example.awssqs.unittest',datestr(now)],'ReplacementStyle','delete'));
            createQueueResult = sqs.createQueue(uniqName);
            queueUrl = createQueueResult.getQueueUrl();
            testCase.verifyNotEmpty(queueUrl);
            listQueueResult = sqs.listQueues(uniqName);
            urlList = listQueueResult.getQueueUrls();

            % verify that there is one and only one match with the queue
            % only one match expected due to use of the prefix
            testCase.verifyNumElements(urlList, 1);

            % cleanup
            deleteQueueResult = sqs.deleteQueue(queueUrl);
            testCase.verifyTrue(strcmp(deleteQueueResult.toString(), '{}'));
            pause(1.1) % pause to insure a new timestamp
            sqs.shutdown;
        end

        function testListCreateDeleteQueues(testCase)
            write(testCase.logObj,'debug','Testing testListCreateDeleteQueues');
            % Create the client
            sqs = aws.sqs.Client();
            sqs.useCredentialsProviderChain = false;
            sqs.initialize();
            testCase.verifyNotEmpty(sqs.Handle);

            % Create a queue
            uniqName = lower(matlab.lang.makeValidName(['com.example.awssqs.unittest',datestr(now)],'ReplacementStyle','delete'));
            createQueueResult = sqs.createQueue(uniqName);
            queueUrl = createQueueResult.getQueueUrl();
            testCase.verifyNotEmpty(queueUrl);

            % Verify the queue is on the queue list once only
            listQueuesResult = sqs.listQueues();
            urlList = listQueuesResult.getQueueUrls();
            testCase.verifyEqual(sum(strcmp(urlList, queueUrl)), 1);

            % Delete the queue
            deleteQueueResult = sqs.deleteQueue(queueUrl);
            testCase.verifyTrue(strcmp(deleteQueueResult.toString(), '{}'));
            pause(60);

            % Verify the queue is not the queue list following delete
            listQueuesResult = sqs.listQueues();
            urlList = listQueuesResult.getQueueUrls();
            testCase.verifyEqual(sum(strcmp(urlList, queueUrl)), 0);

            % Cleanup
            testCase.verifyError(@()sqs.deleteQueue(''),'MATLAB:Java:GenericException')
            pause(1.1) % pause to insure a new timestamp
            sqs.shutdown;
        end

        function testdeleteQueue(testCase)
            write(testCase.logObj,'debug','Testing testdeleteQueue');
            % Create the client
            sqs = aws.sqs.Client();
            sqs.useCredentialsProviderChain = false;
            sqs.initialize();
            testCase.verifyNotEmpty(sqs.Handle);

            % Delete a queue with no name & catch failure
            testCase.verifyError(@()sqs.deleteQueue(''),'MATLAB:Java:GenericException')

            % cleanup
            sqs.shutdown;
        end

        function testSendReceiveDeleteMessage(testCase)
            write(testCase.logObj,'debug','Testing testSendReceiveDeleteMessage');
            % Create the client
            sqs = aws.sqs.Client();
            sqs.useCredentialsProviderChain = false;
            sqs.initialize();
            testCase.verifyNotEmpty(sqs.Handle);

            % Create a queue in order to have something to list
            uniqName = lower(matlab.lang.makeValidName(['com.mathworks.awssqs.unittest',datestr(now)],'ReplacementStyle','delete'));
            createQueueResult = sqs.createQueue(uniqName);
            queueUrl = createQueueResult.getQueueUrl();
            testCase.verifyNotEmpty(queueUrl);

            % Send a unique message
            messageBody = ['SQS test ',datestr(now)];
            sendMessageResult = sqs.sendMessage(queueUrl, messageBody);
            sentMessageId = sendMessageResult.getMessageId();
            testCase.verifyNotEmpty(sentMessageId);

            % Receive messages
            receiveMessageResult = sqs.receiveMessage(queueUrl);
            messages = receiveMessageResult.getMessages();
            testCase.verifyGreaterThan(numel(messages), 0);
            % only 1 message sent to the queue
            testCase.verifyEqual(numel(messages), 1);

            % Check if the sent message is in received messages
            messageRxd = false;
            receiptHandle = '';
            ctr = 0;
            for n = 1:numel(messages)
                if strcmp(messages{n}.getMessageId(), sentMessageId)
                    messageRxd = true;
                    receiptHandle = messages{n}.getReceiptHandle();
                    rxBody = messages{n}.getBody();
                    ctr = ctr + 1;
                end
            end
            testCase.verifyTrue(messageRxd);
            testCase.verifyEqual(ctr, 1);
            testCase.verifyTrue(strcmp(messageBody, rxBody));

            % Delete the message
            deleteMessageResult = sqs.deleteMessage(queueUrl, receiptHandle);
            testCase.verifyTrue(strcmp(deleteMessageResult.toString(), '{}'));

            % Check received message not received again i.e. on 2nd call
            % messages should be empty
            receiveMessageResult = sqs.receiveMessage(queueUrl);
            messages = receiveMessageResult.getMessages();
            testCase.verifyEqual(numel(messages), 0);

            % Cleanup
            deleteQueueResult = sqs.deleteQueue(queueUrl);
            testCase.verifyTrue(strcmp(deleteQueueResult.toString(), '{}'));
            pause(1.1)
            sqs.shutdown;
        end

        function testSetGetQueueAttributes(testCase)
            write(testCase.logObj,'debug','Testing testSetGetQueueAttributes');
            sqs = aws.sqs.Client();
            sqs.useCredentialsProviderChain = false;
            sqs.initialize();
            testCase.verifyNotEmpty(sqs.Handle);

            % create a queue in order to have something to list
            uniqName = lower(matlab.lang.makeValidName(['com.mathworks.awssqs.unittest',datestr(now)],'ReplacementStyle','delete'));
            createQueueResult = sqs.createQueue(uniqName);
            queueUrl = createQueueResult.getQueueUrl();
            testCase.verifyNotEmpty(queueUrl);

            % Set 2 attributes
            % DelaySeconds - The length of time, in seconds, for which the
            % delivery of all messages in the queue is delayed. Valid
            % values: An integer from 0 to 900 (15 minutes). Default: 0.
            % MaximumMessageSize - The limit of how many bytes a message
            % can contain before Amazon SQS rejects it. Valid values: An
            % integer from 1,024 bytes (1 KiB) up to 262,144 bytes
            %(256 KiB). Default: 262,144 (256 KiB).
            % KeySet entry/entries
            keySet = {'DelaySeconds', 'MaximumMessageSize'};
            % Corresponding values to the keyset entry/entries
            MMS = 2000;
            DS = 3;
            valueSet = {DS, MMS};
            % Make container map of keySet and valueSet
            M = containers.Map(keySet,valueSet);
            % Set the queue attributes
            setQueueAttributesResult = sqs.setQueueAttributes(queueUrl, M);
            testCase.verifyTrue(strcmp(setQueueAttributesResult.toString(), '{}'));

            % When you change a queue's attributes, the change can take
            % up to 60 seconds for most of the attributes to propagate
            % throughout the Amazon SQS system. Changes made to the
            % MessageRetentionPeriod attribute can take up to 15 minutes
            pause(60);

            getQueueAttributesResult = sqs.getQueueAttributes(queueUrl, keySet);
            attributes = getQueueAttributesResult.getAttributes();
            testCase.verifyNotEmpty(attributes);
            testCase.verifyTrue(strcmp(attributes('MaximumMessageSize'), num2str(MMS)));
            testCase.verifyTrue(strcmp(attributes('DelaySeconds'), num2str(DS)));

            getQueueAttributesResult = sqs.getQueueAttributes(queueUrl, {'All'});
            attributes = getQueueAttributesResult.getAttributes();
            testCase.verifyNotEmpty(attributes);
            testCase.verifyTrue(strcmp(attributes('MaximumMessageSize'), num2str(MMS)));
            testCase.verifyTrue(strcmp(attributes('DelaySeconds'), num2str(DS)));

            % Create char to put in getQueueAttributes queueUrl field
            testChar = 'testgetQueueAttributesEmptyArray';
            %Verify that isempty error check has worked(getQueueAttributes)
            testCase.verifyError(@()sqs.getQueueAttributes(testChar,{}),'AWS:SQS');

            % cleanup
            deleteQueueResult = sqs.deleteQueue(queueUrl);
            testCase.verifyTrue(strcmp(deleteQueueResult.toString(), '{}'));
            sqs.shutdown;
            pause(1.1);
        end
    end
end
