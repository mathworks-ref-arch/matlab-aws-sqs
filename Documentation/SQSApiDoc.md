# MATLAB Interface *for AWS SQS* API documentation


## AWS SQS Interface Objects and Methods:
* @Client



------

## @Client

### @Client/Client.m
```notalanguage
  CLIENT Object to represent an AWS SQS client
  The client is used to carry out operations with the SQS service
 
  Example:
     % Create client
     sqs = aws.sqs.Client;
     % Initialize the client
     sqs.useCredentialsProviderChain = false;
     sqs.initialize();
     % Use the client to carry out actions on SQS
     createQueueResult = sqs.createQueue('myQueueName');
     % Shutdown the client when no longer needed
     sqs.shutdown();

    Reference page in Doc Center
       doc aws.sqs.Client




```
### @Client/createQueue.m
```notalanguage
  CREATEQUEUE Creates an AWS SQS queue
  Create a new standard queue, FIFO queues are not currently supported.
  To create a queue, provide a queue name that adheres to queue name
  restrictions and is unique within the queue scope.
  If a user attempts to create a queue that already exists, SQS will revert
  to that queue instead of creating one with the same name.
  More details on queue limits can be found at:
  https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-limits.html#limits-queues
  A CreateQueueResult object is returned.
 
  Example:
     sqs = aws.sqs.Client;
     sqs.intialialize();
     createQueueResult = sqs.createQueue('MyQueueName');
     queueUrl = createQueueResult.getQueueUrl();



```
### @Client/deleteMessage.m
```notalanguage
  DELETEMESSAGE Deletes the specified message from the specified SQS queue
  Specify the message using the message's receipt handle, not the message ID
  received when the message was sent.
  The receipt handle is an identifier provided when a message is received from a
  queue. A DeleteMessageResult object is returned.
 
  Example:
     receiveMessageResult = sqs.receiveMessage(queueUrl);
     messages = receiveMessageResult.getMessages();
     receiptHandle = messages{1}.getReceiptHandle();
     deleteMessageResult = sqs.deleteMessage(queueUrl, receiptHandle);
     tf = strcmp(deleteMessageResult.toString(), '{}');



```
### @Client/deleteQueue.m
```notalanguage
  DELETEQUEUE Delete an AWS SQS queue
  Deletes the SQS queue specified by the queue URL, regardless of the queue's
  contents. If the specified queue does not exist, SQS throws a
  QueueDoesNotExistException. The deletion process takes up to 60 seconds and
  a user must wait at least 60 seconds before creating another queue with the
  same name. A DeleteQueueResult object is returned.
 
  Example:
     deleteQueueResult = sqs.deleteQueue(queueUrl);
     tf = strcmp(deleteQueueResult.toString(), '{}'));



```
### @Client/getQueueAttributes.m
```notalanguage
  GETQUEUEATTRIBUTES Gets attributes for the specified queue URL
  Attribute names can be specified in a cell array or all attributes for the
  queue can be returned by using 'All' as the only entry in the cell array.
  A GetQueueAttributesResult object is returned. Attribute value are stored as
  character vectors.
 
  Example:
     attributeNames = {'DelaySeconds', 'MaximumMessageSize'};
     getQueueAttributesResult = sqs.getQueueAttributes(queueUrl, attributeNames);
     attributes = getQueueAttributesResult.getAttributes();
     maximumMessageSize = attributes('MaximumMessageSize');
     delaySeconds = attributes('DelaySeconds');



```
### @Client/initialize.m
```notalanguage
  INITIALIZE Configure the MATLAB session to connect to SQS
  Once a client has been configured, initialize is used to validate the
  client configuration and initiate the connection to SQS
 
  Example:
     sqs = aws.sqs.Client();
     sqs.intialize();



```
### @Client/listQueues.m
```notalanguage
  LISTQUEUES Lists SQS queues
  The maximum number of queues that can be returned is 1000.
  If you specify a value for the optional queueNamePrefix parameter
  only queues with a name that begins with the specified value are returned.
  If the queue has recently been created it can take up to a minute to
  appear in the list. A ListQueueResult is returned, from which the queue URLs
  can be obtained.
 
  Example:
     % Without a prefix
     sqs = aws.sqs.Client();
     sqs.initialize();
     listQueueResult = sqs.listQueues(uniqName);
     urlList = listQueueResult.getQueueUrls();



```
### @Client/receiveMessage.m
```notalanguage
  RECEIVEMESSAGE Receives up to 10 messages from an SQS queue
  If the number of messages in the queue is very small, there is no
  guarantee that you will receive any messages in a particular
  response. If this happens, repeat the request. A ReceiveMessageResult object
  is returned, from which the messages can be obtained.
 
  Example:
     receiveMessageResult = sqs.receiveMessage(queueUrl);
     messages = receiveMessageResult.getMessages();
     messageBody = messages{1}.getBody();



```
### @Client/sendMessage.m
```notalanguage
  SENDMESSAGE Delivers a message to the specified queue
  A message can include only XML, JSON, and unformatted text. The following
  Unicode characters are allowed:
 
  #x9 | #xA | #xD | #x20 to #xD7FF | #xE000 to #xFFFD | #x10000 to #x10FFFF
 
  Any characters not included in this list will be rejected.
  Duplicate messages are allowed. A SendMessageResult object is returned.
  The upper limit and default maximum message size is 262144 bytes.
 
  Example:
     messageBody = 'SQS test message';
     sendMessageResult = sqs.sendMessage(queueUrl, messageBody);
     sentMessageId = sendMessageResult.getMessageId();



```
### @Client/setQueueAttributes.m
```notalanguage
  SETQUEUEATTRIBUTES Sets the value of one or more queue attributes
  When you change a queue's attributes the change can take up to 60 seconds
  for the attributes to propagate throughout the SQS system.
  However, changes made to the MessageRetentionPeriod attribute can take up
  to 15 minutes. A list of parameters can be found in the parameters section at:
  https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/index.html?com/amazonaws/services/sqs/AmazonSQSClient.html
 
  Example:
     keySet = {'DelaySeconds', 'MaximumMessageSize'};
     % Corresponding values to the keyset entry/entries
     valueSet = {3, 2000};
     % Make container map of keySet and valueSet
     M = containers.Map(keySet,valueSet);
     % Set the queue attributes
     setQueueAttributesResult = sqs.setQueueAttributes(queueUrl, M);
     tf = strcmp(setQueueAttributesResult.toString(), '{}');



```
### @Client/shutdown.m
```notalanguage
  SHUTDOWN Method to shutdown an SQS client and release resources.
  This method should be called to cleanup a client which is no longer
  required.
 
  Example:
     sqs = aws.sqs.Client;
     % Perform operations using Client
     sqs.shutdown;



```

------
## AWS SQS Interface +model Objects and Methods:
* @CreateQueueResult
* @DeleteMessageResult
* @DeleteQueueResult
* @GetQueueAttributesResult
* @ListQueuesResult
* @Message
* @ReceiveMessageResult
* @SendMessageResult
* @SetQueueAttributesResult



------

## @CreateQueueResult

### @CreateQueueResult/CreateQueueResult.m
```notalanguage
  CREATEQUEUERESULT Object to represent the result of a createQueue call
  The queue URL is obtained from this class.
 
  Example:
     createQueueResult = sqs.createQueue(uniqName);
     queueUrl = createQueueResult.getQueueUrl();

    Reference page in Doc Center
       doc aws.sqs.model.CreateQueueResult




```
### @CreateQueueResult/getQueueUrl.m
```notalanguage
  GETQUEUEURL Returns the URL of the queue
  The URL is returned as a character vector



```

------


## @DeleteMessageResult

### @DeleteMessageResult/DeleteMessageResult.m
```notalanguage
  DELETEMESSAGERESULT Object to represent the result of a deleteMessage call
 
  Example:
     deleteMessageResult = sqs.deleteMessage(queueUrl, receiptHandle);
     tf = strcmp(deleteMessageResult.toString(), '{}');

    Reference page in Doc Center
       doc aws.sqs.model.DeleteMessageResult




```
### @DeleteMessageResult/toString.m
```notalanguage
  TOSTRING Returns a string representation of this object
  This is useful for testing and debugging. Sensitive data will be redacted
  from this string using a placeholder value.
  The result is returned as a character vector.
  '{}' is expected on success.



```

------


## @DeleteQueueResult

### @DeleteQueueResult/DeleteQueueResult.m
```notalanguage
  DELETEQUEUERESULT Object to represent the result of a deleteMessage call
 
  Example:
     deleteQueueResult = sqs.deleteQueue(queueUrl);
     tf = strcmp(deleteQueueResult.toString(), '{}');

    Reference page in Doc Center
       doc aws.sqs.model.DeleteQueueResult




```
### @DeleteQueueResult/toString.m
```notalanguage
  TOSTRING Returns a string representation of this object
  This is useful for testing and debugging. Sensitive data will be redacted
  from this string using a placeholder value.
  The result is returned as a character vector.
  '{}' is expected on success.



```

------


## @GetQueueAttributesResult

### @GetQueueAttributesResult/GetQueueAttributesResult.m
```notalanguage
  GETQUEUEATTRIBUTESRESULT Object to represent the result of a getQueueAttributes call
 
  Example:
     getQueueAttributesResult = sqs.getQueueAttributes(queueUrl, keySet);
     attributes = getQueueAttributesResult.getAttributes();

    Reference page in Doc Center
       doc aws.sqs.model.GetQueueAttributesResult




```
### @GetQueueAttributesResult/getAttributes.m
```notalanguage
  GETATTRIBUTES Returns a topic's attributes
  Attributes are returned as a containers.Map. Attribute keys and values within
  the containers.Map are stored as character values.
 
  Example:
     getQueueAttributesResult = sqs.getQueueAttributes(queueUrl, attributeNames);
     attributes = getQueueAttributesResult.getAttributes();
     maximumMessageSize = attributes('MaximumMessageSize');



```

------


## @ListQueuesResult

### @ListQueuesResult/ListQueuesResult.m
```notalanguage
  LISTQUEUESRESULT Object to represent the result of a listQueues call
 
  Example:
     listQueuesResult = sqs.listQueues();
     urlList = listQueuesResult.getQueueUrls();

    Reference page in Doc Center
       doc aws.sqs.model.ListQueuesResult




```
### @ListQueuesResult/getQueueUrls.m
```notalanguage
  GETQUEUEURLS Returns a list of queue URLs
  The URLs are returned as a cell array of character vectors. If not queue are
  listed then an empty cell array is returned.
 
  Example:
     listQueuesResult = sqs.listQueues();
     urlList = listQueuesResult.getQueueUrls();



```

------


## @Message

### @Message/Message.m
```notalanguage
  MESSAGE Object to represent an SQS message
 
  Example:
     receiveMessageResult = sqs.receiveMessage(queueUrl);
     messages = receiveMessageResult.getMessages();
     for n = 1:numel(messages)
        id = messages{n}.getMessageId();
        receiptHandle = messages{n}.getReceiptHandle();
        body = messages{n}.getBody();
     end

    Reference page in Doc Center
       doc aws.sqs.model.Message




```
### @Message/getBody.m
```notalanguage
  GETBODY returns the body of the message
  The body is returned as a character vector.



```
### @Message/getMessageId.m
```notalanguage
  GETMESSAGEID returns the messageId of the message
  The messageId is returned as a character vector.



```
### @Message/getReceiptHandle.m
```notalanguage
  GETRECEIPTHANDLE returns the receiptHandle of the message
  The receiptHandle is returned as a character vector. It is required to delete
  a message.



```

------


## @ReceiveMessageResult

### @ReceiveMessageResult/ReceiveMessageResult.m
```notalanguage
  RECEIVEMESSAGERESULT Object to represent the result of a receiveMessage call
 
  Example:
     receiveMessageResult = sqs.receiveMessage(queueUrl);
     messages = receiveMessageResult.getMessages();

    Reference page in Doc Center
       doc aws.sqs.model.ReceiveMessageResult




```
### @ReceiveMessageResult/getMessages.m
```notalanguage
  GETMESSSAGES Returns a cell array of Message objects
 
  Example:
     receiveMessageResult = sqs.receiveMessage(queueUrl);
     messages = receiveMessageResult.getMessages();



```

------


## @SendMessageResult

### @SendMessageResult/SendMessageResult.m
```notalanguage
  SENDMESSAGERESULT Object to represent the result of a sendMessage call
 
  Example:
     sendMessageResult = sqs.sendMessage(queueUrl, messageBody);
     sentMessageId = sendMessageResult.getMessageId();

    Reference page in Doc Center
       doc aws.sqs.model.SendMessageResult




```
### @SendMessageResult/getMessageId.m
```notalanguage
  GETMESSAGEID returns the messageId of the message
  The messageId is returned as a character vector.



```

------


## @SetQueueAttributesResult

### @SetQueueAttributesResult/SetQueueAttributesResult.m
```notalanguage
  SETQUEUEATTRIBUTESRESULT Object to represent the result of a setQueueAttributes call
 
  Example:
     setQueueAttributesResult = sqs.setQueueAttributes(queueUrl, M);
     tf = strcmp(setQueueAttributesResult.toString(), '{}');

    Reference page in Doc Center
       doc aws.sqs.model.SetQueueAttributesResult




```
### @SetQueueAttributesResult/toString.m
```notalanguage
  TOSTRING Returns a string representation of this object
  This is useful for testing and debugging. Sensitive data will be redacted
  from this string using a placeholder value.
  The result is returned as a character vector.
  '{}' is expected on success.



```

------
## AWS Common Objects and Methods:
* @ClientConfiguration
* @Object



------

## @ClientConfiguration

### @ClientConfiguration/ClientConfiguration.m
```notalanguage
  CLIENTCONFIGURATION creates a client network configuration object
  This class can be used to control client behavior such as:
   * Connect to the Internet through proxy
   * Change HTTP transport settings, such as connection timeout and request retries
   * Specify TCP socket buffer size hints
  (Only limited proxy related methods are currently available)
 
  Example, in this case using an s3 client:
    s3 = aws.s3.Client();
    s3.clientConfiguration.setProxyHost('proxyHost','myproxy.example.com');
    s3.clientConfiguration.setProxyPort(8080);
    s3.initialize();

    Reference page in Doc Center
       doc aws.ClientConfiguration




```
### @ClientConfiguration/setProxyHost.m
```notalanguage
  SETPROXYHOST Sets the optional proxy host the client will connect through
  This is based on the setting in the MATLAB preferences panel. If the host
  is not set there on Windows then the Windows system preferences will be
  used. Though it is not normally the case proxy settings may vary based on the
  destination URL, if this is the case a URL should be provided for a specific
  service. If a URL is not provided then https://s3.amazonaws.com is used as
  a default and is likely to match the relevant proxy selection rules for AWS
  traffic.
 
  Examples:
 
    To have the proxy host automatically set based on the MATLAB preferences
    panel using the default URL of 'https://s3.amazonaws.com:'
        clientConfig.setProxyHost();
 
    To have the proxy host automatically set based on the given URL:
        clientConfig.setProxyHost('autoURL','https://examplebucket.amazonaws.com');
 
    To force the value of the proxy host to a given value, e.g. myproxy.example.com:
        clientConfig.setProxyHost('proxyHost','myproxy.example.com');
    Note this does not overwrite the value set in the preferences panel.
 
  The client initialization call will invoke setProxyHost() to set a value based
  on the MATLAB preference if the proxyHost value is not to an empty value.



```
### @ClientConfiguration/setProxyPassword.m
```notalanguage
  SETPROXYPASSWORD Sets the optional proxy password
  This is based on the setting in the MATLAB preferences panel. If the password
  is not set there on Windows then the Windows system preferences will be
  used.
 
  Examples:
 
    To set the password to a given value:
        clientConfig.setProxyPassword('myProxyPassword');
    Note this does not overwrite the value set in the preferences panel.
 
    To set the password automatically based on provided preferences:
        clientConfig.setProxyPassword();
 
  The client initialization call will invoke setProxyPassword() to set
  a value based on the MATLAB preference if the proxy password value is set.
 
  Note, it is bad practice to store credentials in code, ideally this value
  should be read from a permission controlled file or other secure source
  as required.



```
### @ClientConfiguration/setProxyPort.m
```notalanguage
  SETPROXYPORT Sets the optional proxy port the client will connect through
  This is normally based on the setting in the MATLAB preferences panel. If the
  port is not set there on Windows then the Windows system preferences will be
  used. Though it is not normally the case proxy settings may vary based on the
  destination URL, if this is the case a URL should be provided for a specific
  service. If a URL is not provided then https://s3.amazonaws.com is used as
  a default and is likely to match the relevant proxy selection rules for AWS
  traffic.
 
  Examples:
 
    To have the port automatically set based on the default URL of
    https://s3.amazonaws.com:
        clientConfig.setProxyPort();
 
    To have the port automatically set based on the given URL:
        clientConfig.setProxyPort('https://examplebucket.amazonaws.com');
 
    To force the value of the port to a given value, e.g. 8080:
        clientConfig.setProxyPort(8080);
    Note this does not alter the value held set in the preferences panel.
 
  The client initialization call will invoke setProxyPort() to set a value based
  on the MATLAB preference if the proxy port value is not an empty value.



```
### @ClientConfiguration/setProxyUsername.m
```notalanguage
  SETPROXYUSERNAME Sets the optional proxy username
  This is based on the setting in the MATLAB preferences panel. If the username
  is not set there on Windows then the Windows system preferences will be
  used.
 
  Examples:
 
     To set the username to a given value:
         clientConfig.setProxyUsername('myProxyUsername');
     Note this does not overwrite the value set in the preferences panel.
 
     To set the password automatically based on provided preferences:
         clientConfig.setProxyUsername();
 
  The client initialization call will invoke setProxyUsername();
  to set preference based on the MATLAB preference if the proxyUsername value is
  not an empty value.
 
  Note it is bad practice to store credentials in code, ideally this value
  should be read from a permission controlled file or other secure source
  as required.



```

------


## @Object

### @Object/Object.m
```notalanguage
  OBJECT Root object for all the AWS SDK objects

    Reference page in Doc Center
       doc aws.Object




```

------

## AWS Common Related Functions:
### functions/Logger.m
```notalanguage
  Logger - Object definition for Logger
  ---------------------------------------------------------------------
  Abstract: A logger object to encapsulate logging and debugging
            messages for a MATLAB application.
 
  Syntax:
            logObj = Logger.getLogger();
 
  Logger Properties:
 
      LogFileLevel - The level of log messages that will be saved to the
      log file
 
      DisplayLevel - The level of log messages that will be displayed
      in the command window
 
      LogFile - The file name or path to the log file. If empty,
      nothing will be logged to file.
 
      Messages - Structure array containing log messages
 
  Logger Methods:
 
      clearMessages(obj) - Clears the log messages currently stored in
      the Logger object
 
      clearLogFile(obj) - Clears the log messages currently stored in
      the log file
 
      write(obj,Level,MessageText) - Writes a message to the log
 
  Examples:
      logObj = Logger.getLogger();
      write(logObj,'warning','My warning message')
 



```
### functions/aws.m
```notalanguage
  AWS, a wrapper to the AWS CLI utility
 
  The function assumes AWS CLI is installed and configured with authentication
  details. This wrapper allows use of the AWS CLI within the
  MATLAB environment.
 
  Examples:
     aws('s3api list-buckets')
 
  Alternatively:
     aws s3api list-buckets
 
  If no output is specified, the command will echo this to the MATLAB
  command window. If the output variable is provided it will convert the
  output to a MATLAB object.
 
    [status, output] = aws('s3api','list-buckets');
 
      output =
 
        struct with fields:
 
            Owner: [1x1 struct]
          Buckets: [15x1 struct]
 
  By default a struct is produced from the JSON format output.
  If the --output [text|table] flag is set a char vector is produced.
 



```
### functions/homedir.m
```notalanguage
  HOMEDIR Function to return the home directory
  This function will return the users home directory.



```
### functions/isEC2.m
```notalanguage
  ISEC2 returns true if running on AWS EC2 otherwise returns false



```
### functions/loadKeyPair.m
```notalanguage
  LOADKEYPAIR2CERT Reads public and private key files and returns a key pair
  The key pair returned is of type java.security.KeyPair
  Algorithms supported by the underlying java.security.KeyFactory library
  are: DiffieHellman, DSA & RSA.
  However S3 only supports RSA at this point.
  If only the public key is a available e.g. the private key belongs to
  somebody else then we can still create a keypair to encrypt data only
  they can decrypt. To do this we replace the private key file argument
  with 'null'.
 
  Example:
   myKeyPair = loadKeyPair('c:\Temp\mypublickey.key', 'c:\Temp\myprivatekey.key')
 
   encryptOnlyPair = loadKeyPair('c:\Temp\mypublickey.key')
 
 



```
### functions/saveKeyPair.m
```notalanguage
  SAVEKEYPAIR Writes a key pair to two files for the public and private keys
  The key pair should be of type java.security.KeyPair
 
  Example:
    saveKeyPair(myKeyPair, 'c:\Temp\mypublickey.key', 'c:\Temp\myprivatekey.key')
 



```
### functions/unlimitedCryptography.m
```notalanguage
  UNLIMITEDCRYPTOGRAPHY Returns true if unlimited cryptography is installed
  Otherwise false is returned.
  Tests using the AES algorithm for greater than 128 bits if true then this
  indicates that the policy files have been changed to enabled unlimited
  strength cryptography.



```
### functions/writeSTSCredentialsFile.m
```notalanguage
  WRITESTSCREDENTIALSFILE write an STS based credentials file
 
  Write an STS based credential file
 
    tokenCode is the 2 factor authentication code of choice e.g. from Google
    authenticator. Note the command must be issued quickly as this value will
    expire in a number of seconds
 
    serialNumber is the AWS 'arn value' e.g. arn:aws:iam::741<REDACTED>02:mfa/joe.blog
    this can be obtained from the AWS IAM portal interface
 
    region is the AWS region of choice e.g. us-west-1
 
  The following AWS command line interface (CLI) command will return STS
  credentials in json format as follows, Note the required multi-factor (mfa)
  auth version of the arn:
 
  aws sts get-session-token --token-code 631446 --serial-number arn:aws:iam::741<REDACTED>02:mfa/joe.blog
 
  {
      "Credentials": {
          "SecretAccessKey": "J9Y<REDACTED>BaJXEv",
          "SessionToken": "FQoDYX<REDACTED>KL7kw88F",
          "Expiration": "2017-10-26T08:21:18Z",
          "AccessKeyId": "AS<REDACTED>UYA"
      }
  }
 
  This needs to be rewritten differently to match the expected format
  below:
 
  {
      "aws_access_key_id": "AS<REDACTED>UYA",
      "secret_access_key" : "J9Y<REDACTED>BaJXEv",
      "region" : "us-west-1",
      "session_token" : "FQoDYX<REDACTED>KL7kw88F"
  }



```



------------    

[//]: # (Copyright 2019 The MathWorks, Inc.)
