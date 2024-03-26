# Messaging Data Point Configurations

This document describes the messaging specific part of a data-point description.
There are several distinct combinations possible, depending on the device.

The API suports the following functions:

- getVal(functionalProfile, dataPoint)
- setVal(functionalProfile, dataPoint, value)
- subscribe(functionalProfile, dataPoint, callback) // subscribe to a topic for receiving messages asynchronously.

## Communication flows

### Flow `setVal(functionalProfile, dataPoint, value)`
```
[Communicator] - msg(set value) -> [Broker] - msg(set value) -> [Device]
```

### Flow `getVal(functionalProfile, dataPoint, optional<timeout>)`
```
[Communicator] - msg(read cmd)  --> [Broker] - msg(read cmd) -->  [Device]
[Communicator] <-- msg(read resp) - [Broker] <-- msg(read resp)-  [Device]
```

### Flow `subscribe(functionalProfile, dataPoint, callback)`
```
[Communicator] - msg(subscribe) --> [Broker] - msg(subscribe) --> [Device]
[Communicator] <-- msg(value)   --- [Broker] <-- msg(value)   --- [Device]
               <-- msg(value)   --- [Broker] <-- msg(value)   ---
               <-- msg(value)   --- [Broker] <-- msg(value)   ---          
```

### Flow `unsubscribe()`
TODO

## Datapoint types

### R readonly data-point supporting `subscribe()` only

This data-point supports only subscribing to a 'topic'.
There is no read command available. 
Only the element `<inMessage>` is defined.
Only the method `subscribe(functionalProfile, dataPoint, callback)` is supported.

```xml
  <messagingDataPointConfiguration>
    <messagingDataType>
      <number/>
    </messagingDataType>
    <inMessage>
      <topic>sensors/analogue/voltage_dc_in1</topic>
    </inMessage>
  </messagingDataPointConfiguration>
```

### R readonly data-point supporting `getVal()` and `subscribe()`

A `<readCmdMessage>` and a `<inMessage>`element must be defined.

The read command is used to trigger the response message.
Whether a command to trigger value reading depends on the device.

```xml
 <messagingDataPointConfiguration>
    <messagingDataType>
      <number/>
    </messagingDataType>
    <readCmdMessage>
      <topic>sensors/analogue/voltage_dc_in1</topic>
      <template>read</template>
    </readCmdMessage>
    <inMessage>
      <topic>sensors/analogue/voltage_dc_in1</topic>
    </inMessage>
 </messagingDataPointConfiguration>
```


### W write only data-point supports `setVal()` only

This configuration contains only a `<writeCmdMessage>` element.
The `<writeCmdMessage>` consists of a `<topic>` and a `template` element 
that contains a template for the message to send. The message template string
musst contain a placeholder `{{value}}` that is substituted with the value 
written to the device.

```xml
  <messagingDataPointConfiguration>
    <messagingDataType>
      <number/>
    </messagingDataType>
    <writeCmdMessage>
      <topic>actuator/analgue/voltage_dc_out1</topic>
      <template>{ "command": "write", "value": {{value}} }</template>
    </writeCmdMessage>
  </messagingDataPointConfiguration>

```

### RW data point supports `setVal()`, `getVal()` and `subscribe()`

A RW datapoint must support all three message elements:

```xml
 <messagingDataPointConfiguration>
    <messagingDataType>
      <number/>
    </messagingDataType>
    <readCmdMessage>
      <topic>sensors/analogue/voltage_dc_in1</topic>
      <template>{ "command": "read"}</template>
    </readCmdMessage>
    <writeCmdMessage>
      <topic>actuator/analgue/voltage_dc_out1</topic>
      <template>{ "command": "write", "value": [[value]] }</template>
    </writeCmdMessage>
    <inMessage>
      <topic>sensors/analogue/voltage_dc_in1</topic>
    </inMessage>
 </messagingDataPointConfiguration>
```

###  Child elements for `<inMessage>`

- `<topic>` The topic to send the message to
- `<filter>` The payload filter to accept the message`. One of 
  - `<jmespathFilter>`
  - `<regexFilter`
  - `<xpathFilter>`


```xml
  <inMessage>
    <topic>actuator/analgue/voltage_dc_out1</topic>
    <filter>
      <jmespathFilter>
        <query>sensorId</query>
        <matchesRegex>1</matchesRegex>
      </jmespathFilter>
    </filter>
    <responseQuery>
      <queryType>JMESPathExpression</queryType>
      <query>[0].value</query>
    </responseQuery>
</inMessage>
```


### Child elements for `<writeCmdMessage>`

```xml
  <writeCmdMessage>
    <topic>actuator/analgue/voltage_dc_out1</topic>
    <template>{ "command": "set", "value" : {{value}}} </template>
  </writeCmdMessage>
```


### Child elements for `<readCmdMessage>`

```xml
  <readCmdMessage>
    <topic>actuator/analgue/voltage_dc_in1</topic>
    <template>{ "command": "read" }</template>
  </readCmdMessage>
```
