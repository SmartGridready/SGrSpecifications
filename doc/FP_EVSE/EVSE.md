# EVSE

## Electric Vehicle Supply Equipment (EVSE)

Currently, there are three types of functional profiles for the EVSE

- **[EVSE Current Limit](#evse-current-limit)**: Enables a controller to set a current limitation for an EVSE.
- **[EVSE State](#evse-state)**: Reads the status of the connector of an EVSE
- **[EVSE LoadReduction](#evse-loadreduction)**: Sets the operation mode of the EVSE.

## EVSE Current Limit

The functional profile enables a controller to set a current limitation for an Electric Vehicle Supply Equipment (EVSE).

The charging station's current limit is dynamically regulated by an external Energy Management System (EMS), with the data point <em>EMSCurrentLimit</em> expressed in amps.
This data point enables real-time monitoring and control of the consumption limit of the charging station.
This specific parameter is designed to be easily adjusted by an Energy Manager, allowing for efficient and tailored control of the charging process.

This functional profile can be utilized in conjunction with the [EVSE State](#evse-state) functional profile.

### Main Data Points

The functional profile covers the following main data points

- **EMSCurrentLimit** (mandatory): The maximum current allowed for the charging station at this moment.
- **SafeCurrent** (recommended):  In the event of a communication interruption with the EMS, the EVSE automatically adjusts its current limit to the Safe Current value.
- **MaxReceiveTimeSec** (recommended):  The MaxReceiveTimeSec datapoint signifies the timeout for the stability
             fallback. If the EVSE does not receive communication within the specified
			 <em>MaxReceiveTimeSec</em>, it will automatically limit the current to the
			 <em>SafeCurrent</em> value. 
- **HWCurrentLimit** (optional):  The maximum current allowed for the EVSE is determined by the electrical installation of the charging station and cannot be changed during operation. 

### Feedback Sub Data Points

If the controller requires different datapoints to write and read the values <em>EMSCurrentLimit</em>, <em>SafeCurrent</em>, and <em>MaxReceiveTimeSec</em>,
the data direction of can be changed from RW to W
and an additional sub data point <em>Feedback</em> can be used to read the current value

- <em>EMSCurrentLimit.Feedback</em> for <em>EMSCurrentLimit</em>
- <em>SafeCurrent.Feedback</em> for <em>SafeCurrent</em>
- <em>MaxReceiveTimeSec.Feedback</em> for <em>MaxReceiveTimeSec</em>

These sub data points should not be used if the controller sets and reads the value from the same
data point.

### SmoothTransition Sub Data Points

The [SmoothTransition](../GenericAttributes.md#smooth-transition) sub data points are utilized
to specify the transition process following the reception of a new value for the data points <em>EMSCurrentLimit</em> and <em>SafeCurrent</em>.
The transition process is defined with three sub data points for both main data points

- <em>SmoothTransition_Window</em>: Indicates a time window in which the new operating mode is started randomly. The time window begins with the start command of the operating mode. The value 0 means immediate
		(see winTms [SmoothTransition](../GenericAttributes.md#smooth-transition)).
- <em>SmoothTransition_Delay</em>: Specifies how quickly the changes should be made. The corresponding value is gradually changed from the old to the new value in the specified time.
		(see rmpTms [SmoothTransition](../GenericAttributes.md#smooth-transition)).
- <em>SmoothTransition_Duration</em>: Determines how long the operating mode should be active. When the time has elapsed, the operating mode is automatically terminated. If set to 0 (standard value), the operating mode remains active until a new command is received.
		(see rvrtTms [SmoothTransition](../GenericAttributes.md#smooth-transition)).

Accordingly, the sub data points

- for <em>EMSCurrentLimit</em> are

  - <em>EMSCurrentLimit.SmoothTransition_Window</em>
  - <em>EMSCurrentLimit.SmoothTransition_Delay</em>
  - <em>EMSCurrentLimit.SmoothTransition_Duration</em>

- for <em>SafeCurrent</em> are

  - <em>SafeCurrent.SmoothTransition_Window</em>
  - <em>SafeCurrent.SmoothTransition_Delay</em>
  - <em>SafeCurrent.SmoothTransition_Duration</em>

All six sub data point can be implemented in the device as constant datapoint if the value is constant or as regular datapoint if it can be read from the device.

## EVSE State

Functional profile for reading the status of the connector of an electric vehicle charging station (EVSE).

The current state of the wallbox can be read using the data point ocppState with following values corresponding to the OCPP standard (Open Charge Point Protocol):

- **AVAILABLE**: The charge point is operational and available for a new customer to start a charging session.
- **CHARGING**: A vehicle is currently charging.
- **PREPARING**: The charge point is preparing for a charging session after the driver has been authorized.
- **FINISHING**: The charging process is being concluded (e.g., the vehicle has reached a full charge and the session is being terminated).
- **RESERVED**: The charge point has been reserved for a particular EV driver and is not available to other users.
- **UNAVAILABLE**: The charge point is not in operation and cannot be used to charge a vehicle.
- **FAULTED**: There is a fault in the charge point, requiring maintenance or repair.
- **SUSPENDED_EV_SE**: The charging process has been suspended due to some hardware limitations of the Electric Vehicle Supply Equipment (EVSE).
- **SUSPENDED_EV**: The charging process has been suspended due to some conditions on the vehicle side.

The status of the connector indicates, for example, whether a car is connected to the charging station, if it is currently charging, or if the connector is not connected to the electric vehicle.
The function profile refers to the states offered by the OCPP 1.6 protocol under ocppState.

Knowing the status of the charging station allows an external controller to influence the charging of the car, for example, through the EMS_Current_Limit functional profile.
reserved for a particular EV driver and is not available to other users.

## EVSE LoadReduction

The LoadReduction functional profile sets the operation mode of the EVSE.
Depending on the equipment of the controller one of the following 
functional profiles apply

- SGr level of operation 1 - controllers with one switch with the switching states

  - Switching state **0**: Normal operation, charging according to the configured connection power without any restrictions.
  - Switching state **1**: Minimum charging (AC charging at 6 A, DC charging at 10 kW).

- SGr level of operation 2 - controllers with two switches with the switching states

  - Switching state **0,0**: Normal operation, charging according to the configured connection power without any restrictions.
  - Switching state **0,1**: Reduced charging (e.g. 50 % of the maximum charging power, but never below 6 A).
  - Switching state **1,0**: Minimum charging (e.g. AC charging at 6 A, DC charging at 10 kW).
  - Switching state **1,1**: Charging paused (if bidirectional charging is supported maximum feed-in for Vehicle to Infrastructure V2X).

- SGr level of operation 2m - controllers with the operating states (states can be set and optionally be read)

  - **EV_NORMAL**: Normal operation, charging without any restrictions based on the configured connection power.
  - **EV_REDUCED**: Reduces charging (e.g. to 50 % of the maximum charging power, but not below 6 A).
  - **EV_NONE_OR_FEEDIN**: Charging interrupted (if bidirectional charging is supported maximum feed-in for vehicle to infrastructure V2X).
  - **EV_MINIMAL**: Minimum charging (e.g. AC charging at 6 A, DC charging at 10 kW).
