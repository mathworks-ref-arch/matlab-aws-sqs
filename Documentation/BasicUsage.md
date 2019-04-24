# Basic Usage

## Creating a client
The first step is to create a client to connect to SQS. The client should then be initialized in order to authenticate it. See [Authentication](Authentication.m) for details on providing authentication credentials.

```
sqs = aws.sqs.Client();
% Read credentials from a JSON file rather than the AWS provider chain
sqs.useCredentialsProviderChain = false;
sqs.initialize();
```

## Creating a queue
* Amazon SQS queue names are globally unique, so once a Queue name has been taken by any user, another queue cannot be created with the same name.
*  Amazon SQS assigns each queue an identifier called a queue URL that includes the queue name and other AWS values. The queue URL is used when performing most SQS actions.
* By default each account can create unlimited queues.
* The amount of messages in a queue and the size of the message are however limited, with standard queues there can be a maximum of 120000 in-flight messages. Each message has a max message size of 262,144 bytes (256 KB).
* A queue name can have up to 80 characters. The following characters are accepted: alphanumeric characters, hyphens, and underscores.

The API does not attempt to sanitize the inputs using `matlab.lang.makeValidName()`.
So it is designed to fail in the case of invalid input. Amazon recommends that all Queue names comply with DNS naming conventions. For more details on queue limits please see: <https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-limits.html>
An SQS queue is created by calling the `createQueue()` method.

```
createQueueResult = sqs.createQueue('com-example-myqueue');
queueUrl = createQueueResult.getQueueUrl()

queueUrl =

    'https://sqs.us-west-1.amazonaws.com/74<REDACTED>02/com-example-myqueue'
```

## Deleting a queue
`deleteQueue()` deletes the queue specified by the QueueUrl, regardless of the queue's contents. If the specified queue doesn't exist, Amazon SQS returns a successful response. After the queue is deleted an empty '{}' is returned.

```
deleteQueueResult = sqs.deleteQueue(queueUrl);
deleteSuccess = strcmp(deleteQueueResult.toString(), '{}');
```

**CAUTION** - Since Queue names are globally unique, it is not always possible to recreate a queue of the same name.

## Listing existing queues
`listQueues()` returns a cell array of queue URLs in character vector format.

```
listQueuesResult = sqs.listQueues();
urlList = listQueuesResult.getQueueUrls();
```

## Sending a message
`sendMessage()` delivers a message to the specified queue. A message can include only XML, JSON, and unformatted text. The following Unicode characters are allowed:
#x9 | #xA | #xD | #x20 to #xD7FF | #xE000 to #xFFFD | #x10000 to #x10FFFF
 Any characters not included in this list will be rejected. `sendMessageResult.getMessageId()` returns the messageId.

```
sendMessageResult = sqs.sendMessage(queueUrl, messageBody);
sentMessageId = sendMessageResult.getMessageId();
% messageId's have the form: 'bd13391f-7ddf-40f1-ba49-9bb1a1d6874e'
```

## Receiving messages in a queue
The `receiveMessage()` method returns all the messages in the chosen queue. This method returns a cell array of Message objects, whose messageId, body and receiptHandle can be obtained as character vectors.
```
receiveMessageResult = sqs.receiveMessage(queueUrl);
messages = receiveMessageResult.getMessages();
body = messages{1}.getBody();
receiptHandle = messages{1}.getReceiptHandle();
messageId = messages{1}.getMessageId();
```
If there are no messages in the queue an empty cell array is returned.

## Deleting a message
`deleteMessage()` removes the specified message from the specified queue. Unless versioning has been turned on for the queue, there is no way to undelete a message

```
receiveMessageResult = sqs.receiveMessage(queueUrl);
messages = receiveMessageResult.getMessages();
receiptHandle = messages{1}.getReceiptHandle();
deleteMessageResult = sqs.deleteMessage(queueUrl, receiptHandle);
deleteSuccess = strcmp(deleteMessageResult.toString(), '{}');
```

## Setting the queue attributes
`setQueueAttributes()` sets the value of one or more queue attributes. When changing a queue's attributes, the change can take up to 60 seconds for most of the attributes to
propagate throughout the SQS system. Changes made to the MessageRetentionPeriod attribute can take up to 15 minutes. An attribute map must be created with a keyset and valueset, using the containers.Map method. After the queue attributes are set an empty '{}' is returned.

```
keySet = {'DelaySeconds', 'MaximumMessageSize'};
% Corresponding values to the keyset entry/entries
valueSet = {3, 2000};
% Make container map of keySet and valueSet
M = containers.Map(keySet,valueSet);
% Set the queue attributes
setQueueAttributesResult = sqs.setQueueAttributes(queueUrl, M);
success = strcmp(setQueueAttributesResult.toString(), '{}');
```

A list of all attributes available can be viewed at the parameters section in the [AWS documentation](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/index.html?com/amazonaws/services/sqs/AmazonSQSClient.html)


## Getting the queue attributes
`getQueueAttributes()` gets attributes for the specified queue. The queue URL is provided along with along with the attribute names. Attribute names can be specified in a cell array or all attributes for the queue can be returned by using 'All' as the only entry in the cell array. A GetQueueAttributesResult object is returned. Attribute value within it are stored as
 character vectors.

```
attributeNames = {'DelaySeconds', 'MaximumMessageSize'};
getQueueAttributesResult = sqs.getQueueAttributes(queueUrl, attributeNames);
attributes = getQueueAttributesResult.getAttributes();
maximumMessageSize = attributes('MaximumMessageSize');
delaySeconds = attributes('DelaySeconds');
```

---------------------

[//]: #  (Copyright 2019 The MathWorks, Inc.)
